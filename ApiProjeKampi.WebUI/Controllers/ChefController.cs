using ApiProjeKampi.WebUI.Dtos.ChefDtos;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Text;

namespace ApiProjeKampi.WebUI.Controllers
{
    public class ChefController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public ChefController(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }
        public async Task<IActionResult> ChefList()
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Chefs");
            if (responseMessage.IsSuccessStatusCode)
            {
                var jsondata = await responseMessage.Content.ReadAsStringAsync();
                var values = JsonConvert.DeserializeObject<List<ResultChefDto>>(jsondata);
                return View(values);
            }
            return View();
        }

        [HttpGet]
        public IActionResult AddChef()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AddChef(CreateChefDto createChefDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(createChefDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PostAsync("https://localhost:44311/api/Chefs", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {

                return RedirectToAction("ChefList");
            }
            return View();
        }

        public async Task<IActionResult> DeleteChef(int id)
        {
            var client = _httpClientFactory.CreateClient();
            await client.DeleteAsync("https://localhost:44311/api/Chefs?id=" + id);
            return RedirectToAction("ChefList");
        }
        [HttpGet]
        public async Task<IActionResult> UpdateChef(int id)
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Chefs/" + id);
            var JsonData = await responseMessage.Content.ReadAsStringAsync();
            var value = JsonConvert.DeserializeObject<GetChefByIdDto>(JsonData);
            return View(value);
        }

        [HttpPost]
        public async Task<IActionResult> UpdateChef(UpdateChefDto updateChefDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(updateChefDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PutAsync("https://localhost:44311/api/Chefs", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {
                return RedirectToAction("ChefList");
            }
            return View();
        }
    }
}
