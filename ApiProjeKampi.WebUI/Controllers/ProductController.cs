using ApiProjeKampi.WebUI.Dtos.CategoryDtos;
using ApiProjeKampi.WebUI.Dtos.ProductDtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Newtonsoft.Json;
using System.Text;

namespace ApiProjeKampi.WebUI.Controllers
{
    public class ProductController : Controller
    {
        private readonly IHttpClientFactory _httpClientFactory;

        public ProductController(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }
        public async Task<IActionResult> ProductList()
        {
            var client = _httpClientFactory.CreateClient();
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Products/ProductListWithCategories");
            if (responseMessage.IsSuccessStatusCode)
            {
                var jsondata = await responseMessage.Content.ReadAsStringAsync();
                var values = JsonConvert.DeserializeObject<List<ResultProductDto>>(jsondata);
                return View(values);
            }
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> AddProduct()
        {
            var client = _httpClientFactory.CreateClient();
            var  responseMessage = await client.GetAsync("https://localhost:44311/api/Categories");

            var jsondata = await responseMessage.Content.ReadAsStringAsync();
            var values = JsonConvert.DeserializeObject<List<ResultCategoryDto>>(jsondata);

            List<SelectListItem> categoryValues = (from x in values
                                                   select new SelectListItem
                                                   {
                                                       Text = x.CategoryName,
                                                       Value = x.CategoryId.ToString()
                                                   }).ToList();

            ViewBag.v = categoryValues;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AddProduct(CreateProductDto createProductDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(createProductDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PostAsync("https://localhost:44311/api/Products/CreateProductWithCategory", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {

                return RedirectToAction("ProductList");
            }
            return View();
        }

        public async Task<IActionResult> DeleteProduct(int id)
        {
            var client = _httpClientFactory.CreateClient();
            await client.DeleteAsync("https://localhost:44311/api/Products?id=" + id);
            return RedirectToAction("ProductList");
        }
        [HttpGet]
        public async Task<IActionResult> UpdateProduct(int id)
        {
            var client = _httpClientFactory.CreateClient();

            // Kategori listesi (dropdown için)
            var categoryResponse = await client.GetAsync("https://localhost:44311/api/Categories");
            var categoryJson = await categoryResponse.Content.ReadAsStringAsync();
            var categoryValues = JsonConvert.DeserializeObject<List<ResultCategoryDto>>(categoryJson);
            ViewBag.v = (from x in categoryValues
                         select new SelectListItem
                         {
                             Text = x.CategoryName,
                             Value = x.CategoryId.ToString()
                         }).ToList();

            // Güncellenecek ürünün mevcut bilgileri
            var responseMessage = await client.GetAsync("https://localhost:44311/api/Products/" + id);
            var JsonData = await responseMessage.Content.ReadAsStringAsync();
            var value = JsonConvert.DeserializeObject<GetProductByIdDto>(JsonData);
            return View(value);
        }

        [HttpPost]
        public async Task<IActionResult> UpdateProduct(UpdateProductDto updateProductDto)
        {
            var client = _httpClientFactory.CreateClient();
            var jsondata = JsonConvert.SerializeObject(updateProductDto);
            StringContent stringContent = new StringContent(jsondata, UTF8Encoding.UTF8, "application/json");
            var responseMessage = await client.PutAsync("https://localhost:44311/api/Products", stringContent);
            if (responseMessage.IsSuccessStatusCode)
            {
                return RedirectToAction("ProductList");
            }
            return View();
        }
    }
}
