using ApiProjeKampi.WebApi.Context;
using ApiProjeKampi.WebApi.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ApiProjeKampi.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ServicesController : ControllerBase
    {
        private readonly ApiContext _context;
        public ServicesController(ApiContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetService()
        {
            var Services = _context.Services.ToList();
            return Ok(Services);
        }

        [HttpPost]
        public IActionResult AddService(Service service)
        {
            _context.Services.Add(service);
            _context.SaveChanges();
            return Ok("Service ekleme başarılı.");
        }

        [HttpDelete]
        public IActionResult DeleteService(int id)
        {
            var value = _context.Services.Find(id);
            _context.Services.Remove(value);
            _context.SaveChanges();
            return Ok("Service silme başarılı.");
        }

        [HttpGet("{id}")]
        public IActionResult GetServiceById(int id)
        {
            var value = _context.Services.Find(id);
            return Ok(value);
        }

        [HttpPut]
        public IActionResult UpdateService(Service service)
        {
            _context.Services.Update(service);
            _context.SaveChanges();
            return Ok("Service güncelleme başarılı.");
        }
    }
}
