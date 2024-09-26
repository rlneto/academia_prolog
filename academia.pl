% Discente: Rudolfo Lange Neto

% Enunciado: cinco colegas estão na academia fazendo musculação. Cada um deles está utilizando um aparelho para exercitar um grupo muscular, sendo que os cinco aparelhos estão lado a lado. Observe as dicas e use o raciocínio lógico para associar uma cor de camiseta, um nome, uma profissão, um peso e um treinamento para cada um deles.

% Fonte https://rachacuca.com.br/logica/problemas/colegas-na-academia/

% Modelagem:

% Profissões
profissao(advogado).
profissao(economista).
profissao(engenheiro).
profissao(estudante).
profissao(programador).

% Treinamentos
treinando(biceps).
treinando(ombro).
treinando(peito).
treinando(perna).
treinando(triceps).

% Cores de Camiseta
camiseta(azul).
camiseta(branca).
camiseta(verde).
camiseta(vermelha).
camiseta(amarela).

% Nomes
nome(fausto).
nome(josue).
nome(sato).
nome(tiago).
nome(vinicius).

% Pesos
peso(61).
peso(68).
peso(72).
peso(79).
peso(85).

% Idades
idade(22).
idade(24).
idade(26).
idade(27).
idade(32).

% X está ao lado de Y
aoLado(X, Y, Lista) :- nextto(X, Y, Lista); nextto(Y, X, Lista).

% X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X, Y, Lista) :-
    nth0(IndexX, Lista, X),
    nth0(IndexY, Lista, Y),
    IndexX < IndexY.

% X está à direita de Y (em qualquer posição à direita)
aDireita(X, Y, Lista) :- aEsquerda(Y, X, Lista).

% X está no canto se ele é o primeiro ou o último da lista
noCanto(X, Lista) :- last(Lista, X).
noCanto(X, [X|_]).

% Seleciona o segundo elemento da lista
segundo_elemento(X, [_, X | _]).

% Seleciona o terceiro elemento da lista
terceiro_elemento(X, [_, _, X | _]).

% Todos os elementos são diferentes
todosDiferentes([]).
todosDiferentes([H|T]) :-
    not(member(H, T)),
    todosDiferentes(T).

% X está imediatamente à esquerda de Y
imediatamenteAEsquerda(X, Y, Lista) :- nextto(X, Y, Lista).

% X está imediatamente à direita de Y
imediatamenteADireita(X, Y, Lista) :- nextto(Y, X, Lista).

solucao(ListaSolucao) :- 
    ListaSolucao = [
        aparelho(Camiseta1, Nome1, Profissao1, Idade1, Peso1, Treinando1),
        aparelho(Camiseta2, Nome2, Profissao2, Idade2, Peso2, Treinando2),
        aparelho(Camiseta3, Nome3, Profissao3, Idade3, Peso3, Treinando3),
        aparelho(Camiseta4, Nome4, Profissao4, Idade4, Peso4, Treinando4),
        aparelho(Camiseta5, Nome5, Profissao5, Idade5, Peso5, Treinando5)
    ],

    % 1. A pessoa que está treinando Peito está exatamente à esquerda de quem tem 68 quilos.
    imediatamenteAEsquerda(aparelho(_, _, _, _, _, peito), aparelho(_, _, _, _, 68, _), ListaSolucao),

    % 2. Quem está treinando Tríceps está em algum lugar entre quem tem 32 anos e quem está treinando Bíceps, exatamente nessa ordem.
    aEsquerda(aparelho(_, _, _, 32, _, _), aparelho(_, _, _, _, _, triceps), ListaSolucao),
    aEsquerda(aparelho(_, _, _, _, _, triceps), aparelho(_, _, _, _, _, biceps), ListaSolucao),

    % 3. Quem está treinando Perna está em uma das pontas.
    noCanto(aparelho(_, _, _, _, _, perna), ListaSolucao),

    % 4. A pessoa que tem 61 quilos está ao lado de quem está treinando Peito.
    aoLado(aparelho(_, _, _, _, 61, _), aparelho(_, _, _, _, _, peito), ListaSolucao),

    % 5. Quem está treinando Tríceps está exatamente à direita da pessoa com a camiseta Amarela.
    imediatamenteADireita(aparelho(_, _, _, _, _, triceps), aparelho(amarela, _, _, _, _, _), ListaSolucao),

    % 6. O segundo aparelho está sendo usado pela pessoa de 72 quilos.
    segundo_elemento(aparelho(_, _, _, _, 72, _), ListaSolucao),

    % 7. O Economista pesa 68 quilos.
    member(aparelho(_, _, economista, _, 68, _), ListaSolucao), 

    % 8. A pessoa da camiseta Azul está em algum lugar à esquerda do que tem 27 anos.
    aEsquerda(aparelho(azul, _, _, _, _, _), aparelho(_, _, _, 27, _, _), ListaSolucao),

    % 9. Quem está treinando Ombro está ao lado de quem tem 26 anos.
    aoLado(aparelho(_, _, _, _, _, ombro), aparelho(_, _, _, 26, _, _), ListaSolucao),

    % 10. O Engenheiro está ao lado de quem tem 32 anos.
    aoLado(aparelho(_, _, engenheiro, _, _, _), aparelho(_, _, _, 32, _, _), ListaSolucao),

    % 11. O mais jovem está em uma das pontas.
    noCanto(aparelho(_, _, _, 22, _, _), ListaSolucao),

    % 12. O Advogado está de camiseta Branca.
    member(aparelho(branca, _, advogado, _, _, _), ListaSolucao),

    % 13. O Estudante está treinando Peito.
    member(aparelho(_, _, estudante, _, _, peito), ListaSolucao),

    % 14. Sato tem 85 quilos.
    member(aparelho(_, sato, _, _, 85, _), ListaSolucao),

    % 15. Vinicius está em uma das pontas.
    noCanto(aparelho(_, vinicius, _, _, _, _), ListaSolucao),

    % 16. Josué está usando uma camiseta Amarela.
    member(aparelho(amarela, josue, _, _, _, _), ListaSolucao),

    % 17. Sato está ao lado do Vinicius.
    aoLado(aparelho(_, sato, _, _, _, _), aparelho(_, vinicius, _, _, _, _), ListaSolucao),

    % 18. Tiago está em uma das pontas.
    noCanto(aparelho(_, tiago, _, _, _, _), ListaSolucao),

    % 19. A pessoa de camiseta Amarela está em algum lugar entre Tiago e o Advogado, exatamente nessa ordem.
    aEsquerda(aparelho(_, tiago, _, _, _, _), aparelho(amarela, _, _, _, _, _), ListaSolucao),
    aEsquerda(aparelho(amarela, _, _, _, _, _), aparelho(_, _, advogado, _, _, _), ListaSolucao),

    % 20. A pessoa de camiseta Amarela está em algum lugar entre a pessoa de camiseta Verde e o Vinicius, exatamente nessa ordem.
    aEsquerda(aparelho(verde, _, _, _, _, _), aparelho(amarela, _, _, _, _, _), ListaSolucao),
    aEsquerda(aparelho(amarela, _, _, _, _, _), aparelho(_, vinicius, _, _, _, _), ListaSolucao),

    % 21. Quem está usando a camiseta Amarela está em algum lugar entre a pessoa de 79 quilos e o Fausto, exatamente nessa ordem.
    aEsquerda(aparelho(_, _, _, _, 79, _), aparelho(amarela, _, _, _, _, _), ListaSolucao),
    aEsquerda(aparelho(amarela, _, _, _, _, _), aparelho(_, fausto, _, _, _, _), ListaSolucao),

    % 22. O terceiro aparelho está sendo usado pela pessoa de 26 anos.
    terceiro_elemento(aparelho(_, _, _, 26, _, _), ListaSolucao),

    % Garantir que todas as camisetas sejam diferentes
    camiseta(Camiseta1), camiseta(Camiseta2), camiseta(Camiseta3), camiseta(Camiseta4), camiseta(Camiseta5),
    todosDiferentes([Camiseta1, Camiseta2, Camiseta3, Camiseta4, Camiseta5]),

    % Garantir que todos os nomes sejam diferentes
    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),

    % Garantir que todas as profissões sejam diferentes
    profissao(Profissao1), profissao(Profissao2), profissao(Profissao3), profissao(Profissao4), profissao(Profissao5),
    todosDiferentes([Profissao1, Profissao2, Profissao3, Profissao4, Profissao5]),

    % Garantir que todas as idades sejam diferentes
    idade(Idade1), idade(Idade2), idade(Idade3), idade(Idade4), idade(Idade5),
    todosDiferentes([Idade1, Idade2, Idade3, Idade4, Idade5]),

    % Garantir que todos os pesos sejam diferentes
    peso(Peso1), peso(Peso2), peso(Peso3), peso(Peso4), peso(Peso5),
    todosDiferentes([Peso1, Peso2, Peso3, Peso4, Peso5]),

    % Garantir que todos os treinamentos sejam diferentes
    treinando(Treinando1), treinando(Treinando2), treinando(Treinando3), treinando(Treinando4), treinando(Treinando5),
    todosDiferentes([Treinando1, Treinando2, Treinando3, Treinando4, Treinando5]).
