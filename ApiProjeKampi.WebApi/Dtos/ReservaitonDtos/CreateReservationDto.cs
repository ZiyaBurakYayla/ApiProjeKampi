namespace ApiProjeKampi.WebApi.Dtos.ReservaitonDtos
{
    public class CreateReservationDto
    {
        public string NameSurname { get; set; }
        public string Email { get; set; }
        public string PhoneNo { get; set; }
        public DateTime ReservationDate { get; set; }
        public string ReservationTime { get; set; }
        public int CountOfPeople { get; set; }
        public string Message { get; set; }
        public string ReservationStatus { get; set; }
    }
}
