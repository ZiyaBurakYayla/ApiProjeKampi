using ApiProjeKampi.WebApi.Context;
using ApiProjeKampi.WebApi.Dtos.ImageDtos;
using ApiProjeKampi.WebApi.Entities;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;

namespace ApiProjeKampi.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImagesController : ControllerBase
    {
        private readonly ApiContext _context;
        private readonly IMapper _mapper;
        public ImagesController(ApiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpGet]
        public IActionResult GetImage()
        {
            var Images = _context.Images.ToList();
            return Ok(Images);
        }

        [HttpPost]
        public IActionResult AddImage(CreateImageDto createImageDto)
        {
            var value = _mapper.Map<Image>(createImageDto);
            _context.Images.Add(value);
            _context.SaveChanges();
            return Ok("Image ekleme başarılı.");
        }

        [HttpDelete]
        public IActionResult DeleteImage(int id)
        {
            var value = _context.Images.Find(id);
            _context.Images.Remove(value);
            _context.SaveChanges();
            return Ok("Image silme başarılı.");
        }

        [HttpGet("{id}")]
        public IActionResult GetImageById(int id)
        {
            var value = _context.Images.Find(id);
            return Ok(value);
        }

        [HttpPut]
        public IActionResult UpdateImage(UpdateImageDto updateImageDto)
        {
            var value = _mapper.Map<Image>(updateImageDto);
            _context.Images.Update(value);
            _context.SaveChanges();
            return Ok("Image güncelleme başarılı.");
        }
    }
}




