using ApiProjeKampi.WebApi.Context;
using ApiProjeKampi.WebApi.Dtos.ProductDtos;
using ApiProjeKampi.WebApi.Entities;
using AutoMapper;
using FluentValidation;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ApiProjeKampi.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly IValidator<Product> _validator;
        private readonly ApiContext _context;
        private readonly IMapper _mapper;
        public ProductsController(IValidator<Product> validator, ApiContext context, IMapper mapper)
        {
            _validator = validator;
            _context = context;
            _mapper = mapper;
        }

        [HttpGet]
        public IActionResult ProductList()
        {
            var values = _context.Products.ToList();
            return Ok(values);
        }

        [HttpPost]
        public IActionResult CreateProduct(Product product)
        {
            var values = _validator.Validate(product);
            if (!values.IsValid)
            {
                return BadRequest(values.Errors.Select(x => x.ErrorMessage));
            }
            else
            {
                _context.Products.Add(product);
                _context.SaveChanges();
                return Ok("Product ekleme başarılı.");
            }
        }

        [HttpDelete]
        public IActionResult DeleteProduct(int id)
        {
            var value = _context.Products.Find(id);
            _context.Products.Remove(value);
            _context.SaveChanges();
            return Ok("Product silme başarılı.");
        }

        [HttpPut]
        public IActionResult UpdateProduct(Product product)
        {
            var values = _validator.Validate(product);
            if (!values.IsValid)
            {
                return BadRequest(values.Errors.Select(x => x.ErrorMessage));
            }
            else
            {
                _context.Products.Update(product);
                _context.SaveChanges();
                return Ok("Product güncelleme başarılı.");
            }
        }

        [HttpGet("{id}")]
        public IActionResult GetProduct(int id)
        {
            var value = _context.Products.Find(id);
            return Ok(value);
        }

        [HttpPost("CreateProductWithCategory")]//ilişkili olduğu tabloyla birlikte ekleme yaparken kullanılır
        public IActionResult CreateProductWithCategory(CreateProductDto createProductDto)
        {
            var value = _mapper.Map<Product>(createProductDto);
            _context.Products.Add(value);
            _context.SaveChanges();
            return Ok("Product ekleme başarılı.");
        }

        [HttpGet("ProductListWithCategories")]
        public IActionResult ProductListWithCategories()
        {
            var values = _context.Products.Include(x => x.Category).ToList();
            return Ok(_mapper.Map<List<ResultProductwithCategoryDto>>(values));
        }
    }
}
