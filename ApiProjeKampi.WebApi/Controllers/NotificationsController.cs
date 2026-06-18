using ApiProjeKampi.WebApi.Context;
using ApiProjeKampi.WebApi.Dtos.MessageDtos;
using ApiProjeKampi.WebApi.Dtos.NotificationDtos;
using ApiProjeKampi.WebApi.Entities;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ApiProjeKampi.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationsController : ControllerBase
    {
        private readonly IMapper _mapper;
        private readonly ApiContext _context;
        public NotificationsController(IMapper mapper, ApiContext context)
        {
            _mapper = mapper;
            _context = context;
        }

        [HttpGet]
        public IActionResult NotificationList()
        {
            var values = _context.Notifications.ToList();
            return Ok(_mapper.Map<List<ResultNotificationDto>>(values));
        }

        [HttpGet("{id}")]
        public IActionResult GetByIdNotification(int id)
        {
            var value = _context.Notifications.Find(id);
            return Ok(_mapper.Map<GetNotificationByIdDto>(value));
        }

        [HttpPost]
        public IActionResult CreateNotification(CreateNotificationDto createNotificationDto)
        {
            var value = _mapper.Map<Notification>(createNotificationDto);
            _context.Notifications.Add(value);
            _context.SaveChanges();
            return Ok("Notification ekleme başarılı.");
        }

        [HttpDelete]
        public IActionResult DeleteNotification(int id)
        {
            var value = _context.Notifications.Find(id);
            _context.Notifications.Remove(value);
            _context.SaveChanges();
            return Ok("Notification silme başarılı.");
        }

        [HttpPut]
        public IActionResult UpdateNotification(UpdateNotificationDto updateNotificationDto)
        {
            var value = _mapper.Map<Notification>(updateNotificationDto);
            _context.Notifications.Update(value);
            _context.SaveChanges();
            return Ok("Notification güncelleme başarılı.");
        }

        [HttpGet("NotificationListByIsReadFalse")]
        public IActionResult NotificationListByIsReadFalse()
        {
            var values = _context.Notifications.Where(s => s.IsRead == false).ToList();
            return Ok(_mapper.Map<List<ResultNotificationDto>>(values));
        }
    }
}
