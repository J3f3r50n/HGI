using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Estudos___Lógica___002
{
    class Program
    {
        static void Main(string[] args)
        {
            // Setar variável idade
            var idade = 16;

            // Verifica se a variável idade é maior ou igual a 18
            if ( idade >= 18) 
            { 
                // Se idade maior que 18, escreve no console "Maior de idade"
                Console.WriteLine("Maior de idade");
                // Acrescenta +2 a variável idade
                idade += 2;
                // Escreve novo valor da variável idade na tela
                Console.WriteLine(idade);
            }
            // Caso idade seja menor que 18
            else
            {
                // Escreve na tela "Menor de Idade... informar o responsável"
                Console.WriteLine("Menor de Idade... informe o responsável");
                // Subtraí 2 da variável idade
                idade -= 2;
                // Escreve novo valor da variável idade na tela
                Console.WriteLine(idade);
            }
            // Pausa o software após execução
            Console.Read();
        }
    }
}
