using ApiProjeKampi.WebUI.Dtos.CategoryDtos;
using Humanizer;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Net.Http;

namespace ApiProjeKampi.WebUI.ViewComponents.DashboardViewComponents
{
    public class _DashboardWidgetsComponentPartial : ViewComponent
    {
        private readonly IHttpClientFactory _httpClientFactory; //video 71
         
        public _DashboardWidgetsComponentPartial(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            int r1,r2,r3,r4;
            Random random = new Random();
            r1 = random.Next(1, 35);
            r2 = random.Next(1, 35);
            r3 = random.Next(1, 35);
            r4 = random.Next(1, 35);

            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Reservations/GetTotalReservationCount");
            if (responseMessage.IsSuccessStatusCode)
            {
                var jsondata = await responseMessage.Content.ReadAsStringAsync();
                ViewBag.v1= jsondata;
                ViewBag.r1= r1;
            }


            var client2 = _httpClientFactory.CreateClient();
            var responseMessage2 = await client2.GetAsync("https://localhost:44311/api/Reservations/GetTotalCustomerCount");
            if (responseMessage2.IsSuccessStatusCode)
            {
                var jsondata2 = await responseMessage2.Content.ReadAsStringAsync();
                ViewBag.v2 = jsondata2;
                ViewBag.r2 = r2;
            }

            var client3 = _httpClientFactory.CreateClient();
            var responseMessage3 = await client3.GetAsync("https://localhost:44311/api/Reservations/GetPendingReservations");
            if (responseMessage3.IsSuccessStatusCode)
            {
                var jsondata3 = await responseMessage3.Content.ReadAsStringAsync();
                ViewBag.v3 = jsondata3;
                ViewBag.r3 = r3;
            }

            var client4 = _httpClientFactory.CreateClient();
            var responseMessage4 = await client4.GetAsync("https://localhost:44311/api/Reservations/GetApprovedReservations");
            if (responseMessage4.IsSuccessStatusCode)
            {
                var jsondata4 = await responseMessage4.Content.ReadAsStringAsync();
                ViewBag.v4 = jsondata4;
                ViewBag.r4 = r4;
            }

            return View();
        }
    }
}
