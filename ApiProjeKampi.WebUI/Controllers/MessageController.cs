using ApiProjeKampi.WebUI.Dtos.MessageDtos;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using static ApiProjeKampi.WebUI.Controllers.AIController;

namespace ApiProjeKampi.WebUI.Controllers
{
    public class MessageController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _configuration;

        public MessageController(IHttpClientFactory httpClientFactory ,IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _configuration = configuration;
        }
        public async Task<IActionResult> MessageList()
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Messages");
            if (responseMessage.IsSuccessStatusCode)
            {
                var jsondata = await responseMessage.Content.ReadAsStringAsync();
                var values = JsonConvert.DeserializeObject<List<ResultMessageDto>>(jsondata);
                return View(values);
            }
            return View();
        }

        [HttpGet]
        public IActionResult AddMessage()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AddMessage(CreateMessageDto createMessageDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(createMessageDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PostAsync("https://localhost:44311/api/Messages", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {

                return RedirectToAction("MessageList");
            }
            return View();
        }

        public async Task<IActionResult> DeleteMessage(int id)
        {
            var client = _httpClientFactory.CreateClient();
            await client.DeleteAsync("https://localhost:44311/api/Messages?id=" + id);
            return RedirectToAction("MessageList");
        }

        [HttpGet]
        public async Task<IActionResult> UpdateMessage(int id)
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Messages/" + id);
            var jsonData = await responseMessage.Content.ReadAsStringAsync();
            var value = JsonConvert.DeserializeObject<GetByIdMessageDto>(jsonData);
            return View(value);
        }


        [HttpPost]
        public async Task<IActionResult> UpdateMessage(UpdateMessageDto updateMessageDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsonData = JsonConvert.SerializeObject(updateMessageDto);
            StringContent stringContent = new StringContent(jsonData, Encoding.UTF8, "application/json");
            await client.PutAsync("https://localhost:44311/api/Messages/", stringContent);
            return RedirectToAction("MessageList");
        }

        [HttpGet]
        public async Task<IActionResult> AsnwerMessageWithOpenAI(int id,string prompt)
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Messages/" + id);
            var jsonData = await responseMessage.Content.ReadAsStringAsync();
            var value = JsonConvert.DeserializeObject<GetByIdMessageDto>(jsonData);
            prompt = value.MessageContent;

            var apikey = _configuration["OpenAI:ApiKey"];

            using var client2 = new HttpClient();
            client2.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", apikey);

            var requestData = new
            {
                model = "gpt-3.5-turbo",
                messages = new[]
                {
                    new
                    {
                        role="system",
                        Content="Sen bir restoran için kullanıcılardan gelen mesajları cevaplayan bir yapay zeka aracısın. Amacımız kullanıcı" +
                        "taradından gönderilen mesajlara olabildiğince olumlu samimi ve mantıklı cevaplar vermek olacak."
                    },
                    new
                    {
                        role = "user",
                        Content= prompt
                    }
                },
                temperature = 0.5
            };

            var response = await client2.PostAsJsonAsync("https://api.openai.com/v1/chat/completions", requestData);

            if (response.IsSuccessStatusCode)
            {
                var result = await response.Content.ReadFromJsonAsync<OpenAIResponse>();
                var content = result.choices[0].message.content;
                ViewBag.AnswerAı = content;
            }
            else
            {
                ViewBag.AnswerAı = "Bir hata oluştu: " + response.StatusCode;
            }


            return View(value);
        }


        public PartialViewResult SendMessage()
        {
            return PartialView();
        }

        [HttpPost]
        public async Task<IActionResult> SendMessage(CreateMessageDto createMessageDto)
        {
            var client = new HttpClient();
            var apikey = _configuration["HuggingFace:ApiKey"];
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", apikey);
            try
            {
                var translateRequestBody = new
                {
                    inputs = createMessageDto.MessageContent
                };
                var translateJson = System.Text.Json.JsonSerializer.Serialize(translateRequestBody);
                var translateContent = new StringContent(translateJson, Encoding.UTF8,"application/json");

                var translateResponse = await client.PostAsync("https://router.huggingface.co/hf-inference/models/Helsinki-NLP/opus-mt-tr-en", translateContent);
                var translateResponseString = await translateResponse.Content.ReadAsStringAsync();

                string englishText = createMessageDto.MessageContent;
                if (translateResponseString.TrimStart().StartsWith("["))
                {
                    var translateDoc = JsonDocument.Parse(translateResponseString);
                    englishText = translateDoc.RootElement[0].GetProperty("translation_text").GetString();
                    //ViewBag.v = englishText;
                }

                var toxicRequestBody = new
                {
                    inputs = englishText
                };

                var toxicJson = System.Text.Json.JsonSerializer.Serialize(toxicRequestBody);
                var toxicContent = new StringContent(toxicJson, Encoding.UTF8,"application/json");
                var toxicResponse = await client.PostAsync("https://router.huggingface.co/hf-inference/models/unitary/toxic-bert", toxicContent);
                var toxicResponseString = await toxicResponse.Content.ReadAsStringAsync();

                if (toxicResponseString.TrimStart().StartsWith("["))
                {
                    var toxicDoc = JsonDocument.Parse(toxicResponseString);
                    foreach (var item in toxicDoc.RootElement[0].EnumerateArray())
                    {
                        string label = item.GetProperty("label").GetString();
                        double score = item.GetProperty("score").GetDouble();

                        if (score > 0.5)
                        {
                            createMessageDto.Status = "Toksik Mesaj";
                            break;
                        }
                    }
                }
                if (string.IsNullOrEmpty(createMessageDto.Status))
                {
                    createMessageDto.Status = "Mesaj Alındı";
                }
            }
            catch (Exception ex)
            {
                createMessageDto.Status = "Onay Bekliyor";
            }
            createMessageDto.SendDate = DateTime.Now;

            var client2 = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(createMessageDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client2.PostAsync("https://localhost:44311/api/Messages", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {

                return RedirectToAction("MessageList");
            }
            return View();
        }

    }
}
