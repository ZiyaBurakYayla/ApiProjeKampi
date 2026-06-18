using ApiProjeKampi.WebApi.Context;
using ApiProjeKampi.WebApi.Dtos.ContactDtos;
using ApiProjeKampi.WebApi.Entities;
using Microsoft.AspNetCore.Mvc;

namespace ApiProjeKampi.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ContactsController : ControllerBase
    {
        private readonly ApiContext _context;
        public ContactsController(ApiContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IActionResult ContactList()
        {
            return Ok(_context.Contacts.ToList());
        }


        [HttpPost]
        public IActionResult AddContact(CreateContactDto createContactDto)
        {
            Contact contact = new Contact();
            contact.MapLocation = createContactDto.MapLocation;
            contact.Address = createContactDto.Address;
            contact.PhoneNo = createContactDto.PhoneNo;
            contact.Email = createContactDto.Email;
            contact.OpenHours = createContactDto.OpenHours;
            _context.Contacts.Add(contact);
            _context.SaveChanges();
            return Ok("Contact ekleme başarılı.");
        }

        [HttpDelete]
        public IActionResult DeleteContact(int id)
        {
            var value = _context.Contacts.Find(id);
            _context.Contacts.Remove(value);
            _context.SaveChanges();
            return Ok("Contact silme başarılı.");
        }


        [HttpGet("{id}")]
        public IActionResult GetContactById(int id)
        {
            return Ok(_context.Contacts.Find(id));
        }

        [HttpPut]
        public IActionResult UpdateContact (UpdateContactDto updateContactDto)
        {
            Contact contact = new Contact();
            contact.PhoneNo = updateContactDto.PhoneNo;
            contact.Address = updateContactDto.Address;
            contact.MapLocation = updateContactDto.MapLocation;
            contact.Email = updateContactDto.Email;
            contact.OpenHours = updateContactDto.OpenHours;
            contact.ContactId = updateContactDto.ContactId;
            _context.Contacts.Update(contact);
            _context.SaveChanges();
            return Ok("Contact güncelleme başarılı.");
        }
    }
}
