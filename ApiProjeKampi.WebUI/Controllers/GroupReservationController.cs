using ApiProjeKampi.WebUI.Dtos.GroupReservationDtos;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace ApiProjeKampi.WebUI.Controllers
{
    public class GroupReservationController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public GroupReservationController(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }

        public async Task<IActionResult> GroupReservationList()
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/GroupReservations");
            if (responseMessage.IsSuccessStatusCode)
            {
                var jsonData = await responseMessage.Content.ReadAsStringAsync();
                var values = JsonConvert.DeserializeObject<List<ResultGroupReservationDto>>(jsonData);
                return View(values);
            }
            return View();
        }
    }
}
