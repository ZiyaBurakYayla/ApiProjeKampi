using ApiProjeKampi.WebUI.Dtos.WhyChooseYummyDtos;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Text;

namespace ApiProjeKampi.WebUI.Controllers
{
    public class WhyChooseYummyController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public WhyChooseYummyController(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }
        public async Task<IActionResult> WhyChooseYummyList()
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Services");
            if (responseMessage.IsSuccessStatusCode)
            {
                var jsondata = await responseMessage.Content.ReadAsStringAsync();
                var values = JsonConvert.DeserializeObject<List<ResultWhyChooseYummyDto>>(jsondata);
                return View(values);
            }
            return View();
        }

        [HttpGet]
        public IActionResult AddWhyChooseYummy()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AddWhyChooseYummy(CreateWhyChooseYummyDto createWhyChooseYummyDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(createWhyChooseYummyDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PostAsync("https://localhost:44311/api/Services", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {

                return RedirectToAction("WhyChooseYummyList");
            }
            return View();
        }

        public async Task<IActionResult> DeleteWhyChooseYummy(int id)
        {
            var client = _httpClientFactory.CreateClient();
            await client.DeleteAsync("https://localhost:44311/api/Services?id=" + id);
            return RedirectToAction("WhyChooseYummyList");
        }
        [HttpGet]
        public async Task<IActionResult> UpdateWhyChooseYummy(int id)
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Services/" + id);
            var JsonData = await responseMessage.Content.ReadAsStringAsync();
            var value = JsonConvert.DeserializeObject<GetWhyChooseYummyByIdDto>(JsonData);
            return View(value);
        }

        [HttpPost]
        public async Task<IActionResult> UpdateWhyChooseYummy(UpdateWhyChooseYummyDto updateWhyChooseYummyDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(updateWhyChooseYummyDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PutAsync("https://localhost:44311/api/Services", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {
                return RedirectToAction("WhyChooseYummyList");
            }
            return View();
        }
    }
}
