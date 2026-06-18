using ApiProjeKampi.WebApi.Context;
using ApiProjeKampi.WebApi.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ApiProjeKampi.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TestimonialsController : ControllerBase
    {
        private readonly ApiContext _context;
        public TestimonialsController(ApiContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetTestimonial()
        {
            var Testimonials = _context.Testimonials.ToList();
            return Ok(Testimonials);
        }

        [HttpPost]
        public IActionResult AddTestimonial(Testimonial testimonial)
        {
            _context.Testimonials.Add(testimonial);
            _context.SaveChanges();
            return Ok("Testimonial ekleme başarılı.");
        }

        [HttpDelete]
        public IActionResult DeleteTestimonial(int id)
        {
            var value = _context.Testimonials.Find(id);
            _context.Testimonials.Remove(value);
            _context.SaveChanges();
            return Ok("Testimonial silme başarılı.");
        }

        [HttpGet("{id}")]
        public IActionResult GetTestimonialById(int id)
        {
            var value = _context.Testimonials.Find(id);
            return Ok(value);
        }

        [HttpPut]
        public IActionResult UpdateTestimonial(Testimonial testimonial)
        {
            _context.Testimonials.Update(testimonial);
            _context.SaveChanges();
            return Ok("Testimonial güncelleme başarılı.");
        }
    }
}
