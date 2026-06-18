using ApiProjeKampi.WebApi.Entities;
using FluentValidation;
using System.Data;

namespace ApiProjeKampi.WebApi.ValidationRules
{
    public class ProductValidator : AbstractValidator<Product>
    {
        public ProductValidator()
        {
            RuleFor(p => p.ProductName).NotEmpty().WithMessage("Ürün adı boş geçilemez!");
            RuleFor(p => p.ProductName).MinimumLength(2).WithMessage("Ürün adı en az 2 harf olmalıdır!");
            RuleFor(p => p.ProductName).MaximumLength(50).WithMessage("Ürün adı en fazla 50 harf olmalıdır!");

            RuleFor(a => a.Price).NotEmpty().WithMessage("Fiyat boş geçilemez!").GreaterThan(0).WithMessage
                ("Ürün fiyatı negatif olamaz");

            RuleFor(p => p.Description).NotEmpty().WithMessage("Açıklama boş geçilemez!");
        }
    }
}
