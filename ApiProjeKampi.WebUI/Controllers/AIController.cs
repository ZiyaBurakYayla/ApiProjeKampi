using Microsoft.AspNetCore.Mvc;
using System.Net.Http.Headers;

namespace ApiProjeKampi.WebUI.Controllers
{
    public class AIController : Controller
    {
        private readonly IConfiguration _configuration;

        public AIController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        public IActionResult CreateRecipeWithOpenAI()
        {
            return View();
        }

        [HttpPost]
         public async Task<IActionResult> CreateRecipeWithOpenAI(string prompt)
        {
            var apikey = _configuration["OpenAI:ApiKey"]; 

            using var client = new HttpClient();
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", apikey);

            var requestData = new
            {
                model = "gpt-3.5-turbo",
                messages = new[]
                {
                    new
                    {
                        role="system",
                        Content="Sen bir restoran için yemek önerileri yapan bir yapay zeka aracısın. Amacımız kullanıcı" +
                        "taradından girilen malzemelere göre yemek tarifi önerisinde bulunmak."
                    },
                    new
                    {
                        role = "user",
                        Content= prompt
                    }
                },
                temperature = 0.5
            };

            var response = await client.PostAsJsonAsync("https://api.openai.com/v1/chat/completions", requestData);

            if (response.IsSuccessStatusCode)
            {
                var result = await response.Content.ReadFromJsonAsync<OpenAIResponse>();
                var content = result.choices[0].message.content;
                ViewBag.recipe = content;
            }
            else
            {
                ViewBag.recipe = "Bir hata oluştu: " + response.StatusCode;
            }
            return View();
        }
        


        public class OpenAIResponse
        {
            public List<Choice> choices {  get; set; }
        }

        public class Choice
        {
            public Message message { get; set; }
        }

        public class Message
        {
            public string role { get; set; }
            public string content { get; set; } 
        }
    }
}
