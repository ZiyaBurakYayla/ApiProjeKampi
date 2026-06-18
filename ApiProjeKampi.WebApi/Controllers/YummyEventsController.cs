using ApiProjeKampi.WebApi.Context;
using ApiProjeKampi.WebApi.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ApiProjeKampi.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class YummyEventsController : ControllerBase
    {
        private readonly ApiContext _context;
        public YummyEventsController(ApiContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetYummyEvent()
        {
            var YummyEvents = _context.YummyEvents.ToList();
            return Ok(YummyEvents);
        }

        [HttpPost]
        public IActionResult AddYummyEvent(YummyEvent yummyEvent)
        {
            _context.YummyEvents.Add(yummyEvent);
            _context.SaveChanges();
            return Ok("Event ekleme başarılı.");
        }

        [HttpDelete]
        public IActionResult DeleteYummyEvent(int id)
        {
            var value = _context.YummyEvents.Find(id);
            _context.YummyEvents.Remove(value);
            _context.SaveChanges();
            return Ok("Event silme başarılı.");
        }

        [HttpGet("{id}")]
        public IActionResult GetYummyEventById(int id)
        {
            var value = _context.YummyEvents.Find(id);
            return Ok(value);
        }

        [HttpPut]
        public IActionResult UpdateYummyEvent(YummyEvent yummyEvent)
        {
            _context.YummyEvents.Update(yummyEvent);
            _context.SaveChanges();
            return Ok("Event güncelleme başarılı.");
        }
    }
}
