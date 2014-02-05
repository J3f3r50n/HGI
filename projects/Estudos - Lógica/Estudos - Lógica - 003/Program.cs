using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Estudos___Lógica___003
{
    class Program
    {
        static void Main(string[] args)
        {
            var idade = 17;
            if (idade == 10)
                Console.WriteLine("Tem 10 anos");
            else if (idade >= 10 && idade <=13)
                Console.WriteLine("Tem entre 10 e 13 anos");
            else if (idade >=14 && idade <= 16)
                Console.WriteLine("Tem entre 13 e 16 anos");
            else if (idade >= 17 && idade <= 18)
                Console.WriteLine("Tem entre 16 e 18 anos");
            else if (idade >= 18)
                Console.WriteLine("Tem mais de 18 anos");
            else
                Console.WriteLine("Não declarado");
                Console.Read();
        }
    }
}
