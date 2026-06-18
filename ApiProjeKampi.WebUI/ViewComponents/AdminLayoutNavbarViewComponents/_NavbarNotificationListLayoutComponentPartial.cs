using ApiProjeKampi.WebUI.Dtos.ChefDtos;
using ApiProjeKampi.WebUI.Dtos.NotificationDtos;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace ApiProjeKampi.WebUI.ViewComponents.AdminLayoutNavbarViewComponents
{
    public class _NavbarNotificationListLayoutComponentPartial : ViewComponent
    {
        private readonly IHttpClientFactory _httpClientFactory;
        public _NavbarNotificationListLayoutComponentPartial(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Notifications/NotificationListByIsReadFalse");
            if (responseMessage.IsSuccessStatusCode)
            {
                var jsonData = await responseMessage.Content.ReadAsStringAsync();
                var values = JsonConvert.DeserializeObject<List<NotificationListByIsReadFalseDto>>(jsonData);
                return View(values);
            }
            return View();
        }
    }
}
