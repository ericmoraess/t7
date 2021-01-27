programa
{
	inclua biblioteca ServicosWeb
	inclua biblioteca Objetos
	inclua biblioteca Texto
	inclua biblioteca Util
	const inteiro QTD_ALUNOS = 3, SAIR = 99, CADASTRAR = 1, LISTAR = 2, MAIOR = 3, SINCRONIZAR = 4
	const inteiro QTD_MAX_DISCIPLINAS = 5
	inteiro alunosCadastrados = 0
	
	funcao inicio()
	{	
		//Aluno: nome, nota1, nota2, qtdFaltas
		//nomes[0] = "João", notas1[1] = 6.0,  ...
		//nomes[1] = "Maria", notas1[0] = 6.0, ...
		//nomes[2] = "José", notas1[0] = 6.0, ...
		
		real nota1[QTD_ALUNOS], nota2[QTD_ALUNOS], medias[QTD_ALUNOS]
		cadeia nomes[QTD_ALUNOS]
		inteiro qtdFaltas[QTD_ALUNOS]
		inteiro idades[QTD_ALUNOS]
		caracter sexos[QTD_ALUNOS]
		cadeia registroGeral[QTD_ALUNOS]
											//0      1      2     3       4
		cadeia disciplinas[QTD_MAX_DISCIPLINAS] = { "EDD1", "ED2", "LP1", "PR1", "BD1"}
		
		//fazer o link
		inteiro disciplinaCursada[QTD_ALUNOS][QTD_MAX_DISCIPLINAS]

		
		inteiro opcao = -1
		
		enquanto(opcao != SAIR){
			exibirMenu()
			leia(opcao)

			se(opcao == CADASTRAR){
				//cadastrar(nomes, nota1, nota2, medias)
				cadastrarUsandoObjetos()
			}senao se (opcao == LISTAR){
				listar(nomes, nota1, nota2)
			}senao se (opcao == MAIOR){
				real maior = maiorMedia(medias)
				escreva("estamos processando...")
				Util.aguarde(2000) //aguarda 2 segundos
				escreva("Maior média é: ", maior)
			}
			
		}
			
	}
	 	 	  
	funcao real maiorMedia(real m[]){
		real maior = m[0]
		para(inteiro i=0; i < QTD_ALUNOS; i++){

			se(m[i] > maior){
				maior = m[i]
			}
		}
		
		retorne maior
	}
	
	funcao listar(cadeia nomes[], real n1[], real n2[]){
		para(inteiro i = 0; i < QTD_ALUNOS; i++){
			escreva("\nNome ", nomes[i])
			escreva("\nPrimeira nota ", n1[i])
			escreva("\nSegunda nota ", n2[i])
		}
	}

	funcao inteiro cadastrarAlunoEmObjeto(cadeia nome, real nota1, real nota2, inteiro qtdFaltas){
		inteiro endAluno = Objetos.criar_objeto()
		Objetos.atribuir_propriedade(endAluno, "nome", nome)
		Objetos.atribuir_propriedade(endAluno, "primeiraNota", nota1)
		Objetos.atribuir_propriedade(endAluno, "segundaNota", nota2)
		Objetos.atribuir_propriedade(endAluno, "qtdFaltas", qtdFaltas)
		Objetos.atribuir_propriedade(endAluno, "media", calcularMedia(nota1, nota2))
		retorne endAluno
	}

	funcao vazio cadastrarUsandoObjetos(){
			cadeia nome
			escreva("Digite o nome do aluno: ")
			leia(nome)
			
			real nota1
			escreva("Digite a primeira nota do aluno: ")
			leia(nota1)

			real nota2
			escreva("Digite a segunda nota do aluno: ")
			leia(nota2)

			inteiro qtdFaltas
			escreva("Digite a quantidade de faltas:")
			leia(qtdFaltas)

			inteiro alunoCadastrado = cadastrarAlunoEmObjeto(nome, nota1, nota2, qtdFaltas)
			cadeia json = Objetos.obter_json(alunoCadastrado)
			escreva(json)
			enviarParaServidor(json)
	}

	funcao vazio enviarParaServidor(cadeia json){
		
		cadeia resultado = ServicosWeb.publicar_dados("https://fathomless-lowlands-84112.herokuapp.com/alunos", json)	
		escreva(resultado)
	}
	
	//função? ou procedimento? Quais parametros?
	funcao vazio cadastrar(cadeia nomes[], real n1[], real n2[], real medias[]){
		
		para(inteiro i=0; i < QTD_ALUNOS; i++){
			escreva("Digite o nome do aluno[", i, "]")
			leia(nomes[i])
			
			logico ehValido = validarNome(nomes[i])
			se(ehValido == falso){
				
			}
			
			escreva("Digite a primeira nota do aluno: ")
			leia(n1[i])

			logico ehNotaValida = validarNota(n1[i])
			
			escreva("Digite a segunda nota do aluno: ")
			leia(n2[i])
			medias[i] = calcularMedia(n1[i], n2[i])

		}
		
	}

	funcao real mediaPonderada(real p1, real n1, real p2, real n2){
		retorne ((p1*n1)+(p2*n2)) / (p1+p2)
	}
	
	funcao real calcularMedia(real n1, real n2){
		retorne  (n1 + n2)/2.0
	}
	
	funcao vazio exibirMenu(){
		escreva("\n", CADASTRAR, " - Cadastrar")
		escreva("\n", LISTAR, " - Listar")
		escreva("\n", MAIOR, " - Encontrar Maior Média")
		escreva("\n", SINCRONIZAR, " - SINCRONIZAR")
		escreva("\n", SAIR, " - Sair")
		escreva("\nDigite a opção selecionada: ")
	}

	funcao logico validarNota(real nota){
		//falso: fora do intervalo 0 ~10
		retorne falso
	}

	funcao logico validarNome(cadeia nome){	
		//falso: se o nome for vazio ou se o nome ultrapassar 20 caracteres
		retorne falso
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1065; 
 * @DOBRAMENTO-CODIGO = [112, 136, 140];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */