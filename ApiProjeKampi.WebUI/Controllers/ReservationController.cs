using ApiProjeKampi.WebUI.Dtos.ReservaitonDtos;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Text;

namespace ApiProjeKampi.WebUI.Controllers
{
    public class ReservationController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public ReservationController(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }
        public async Task<IActionResult> ReservationList()
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Reservations");
            if (responseMessage.IsSuccessStatusCode)
            {
                var jsondata = await responseMessage.Content.ReadAsStringAsync();
                var values = JsonConvert.DeserializeObject<List<ResultReservationDto>>(jsondata)
                    .OrderByDescending(x => x.ReservationId)
                    .ToList();
                return View(values);
            }
            return View();
        }

        [HttpGet]
        public IActionResult AddReservation()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AddReservation(CreateReservationDto createReservationDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(createReservationDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PostAsync("https://localhost:44311/api/Reservations", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {

                return RedirectToAction("ReservationList");
            }
            return View();
        }

        public async Task<IActionResult> DeleteReservation(int id)
        {
            var client = _httpClientFactory.CreateClient();
            await client.DeleteAsync("https://localhost:44311/api/Reservations?id=" + id);
            return RedirectToAction("ReservationList");
        }
        [HttpGet]
        public async Task<IActionResult> UpdateReservation(int id)
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Reservations/" + id);
            var JsonData = await responseMessage.Content.ReadAsStringAsync();
            var value = JsonConvert.DeserializeObject<GetReservationByIdDto>(JsonData);
            return View(value);
        }

        [HttpPost]
        public async Task<IActionResult> UpdateReservation(UpdateReservationDto updateReservationDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(updateReservationDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PutAsync("https://localhost:44311/api/Reservations", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {
                return RedirectToAction("ReservationList");
            }
            return View();
        }

        // Onayla / İptal Et / Beklet — kaydı çek, durumunu değiştir, geri kaydet
        public async Task<IActionResult> AccpetReservation(int id)
        {
            await ChangeReservationStatus(id, "Onaylandı");
            return RedirectToAction("ReservationList");
        }

        public async Task<IActionResult> CancelReservation(int id)
        {
            await ChangeReservationStatus(id, "İptal Edildi");
            return RedirectToAction("ReservationList");
        }

        public async Task<IActionResult> WaitReservation(int id)
        {
            await ChangeReservationStatus(id, "Onay Bekliyor");
            return RedirectToAction("ReservationList");
        }

        private async Task ChangeReservationStatus(int id, string status)
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Reservations/" + id);
            var jsondata = await responseMessage.Content.ReadAsStringAsync();
            var value = JsonConvert.DeserializeObject<UpdateReservationDto>(jsondata);

            value.ReservationStatus = status;

            var updateJson = JsonConvert.SerializeObject(value);
            StringContent stringContent = new StringContent(updateJson, UTF8Encoding.UTF8, "application/json");
            await client.PutAsync("https://localhost:44311/api/Reservations", stringContent);
        }
    }
}
