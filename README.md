# Controle de notas

Neste projeto foi desenvolvido um programa em linguagem assembly do MIPS para registrar as notas das atividades de laboratório de Arquitetura de Computadores.

O programa desenvolvido é capaz de:
1) Cadastrar nota de atividade e de projeto de uma turma de 5 alunos de Arquitetura de Computadores.
2) Alterar nota: excluir nota de uma atividade ou de um projeto, de um determinado aluno, informado pelo usuário.
3) Exibir notas: exibir notas e médias de todos os alunos cadastrados (ordenados por RA).
4) Exibir média aritmética das médias da turma
5) Exibir a relação dos aprovados.

:warning:Observações

Quando o programa é inserido é obrigatório a inserção de 5 RAs que irão representar
os alunos no programa. Em seguida usamos o bubble sort para ordenar esses RAs no array que
é guardado. Depois é chamado o menu que o usuário poderá ver as opções de
funcionalidades.

São 5 atividades e 2 projetos, as atividades têm peso 2 cada e os projetos peso 5 cada. A
média de cada aluno é uma média ponderada e as notas podem variar de 0 a 10, de meio em
meio ponto.

#### :red_circle: Execução
> Baixar SPIM: A MIPS32 Simulator.
http://spimsimulator.sourceforge.net/

> Zerar os registradores.

> Carregar o arquivo.s

> Executar
