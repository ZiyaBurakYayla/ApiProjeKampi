using ApiProjeKampi.WebApi.Context;
using ApiProjeKampi.WebApi.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ApiProjeKampi.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChefsController : ControllerBase
    {
        private readonly ApiContext _context;
        public ChefsController(ApiContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IActionResult GetChef()
        {
            return Ok(_context.Chefs.ToList());
        }

        [HttpGet("{id}")]
        public IActionResult GetChefById(int id)
        {
            return Ok(_context.Chefs.Find(id));
        }

        [HttpPost]
        public IActionResult AddChef(Chef chef)
        {
            _context.Chefs.Add(chef);
            _context.SaveChanges();
            return Ok("Chef ekleme başarılı.");
        }

        [HttpDelete]
        public IActionResult DeleteChef(int id)
        {
            var value = _context.Chefs.Find(id);
            _context.Chefs.Remove(value);
            _context.SaveChanges();
            return Ok("Chef silme başarılı.");
        }
        [HttpPut]
        public IActionResult UpdateChef(Chef chef)
        {
            _context.Chefs.Update(chef);
            _context.SaveChanges();
            return Ok("Chef güncelleme başarılı.");
        }
    }
}
