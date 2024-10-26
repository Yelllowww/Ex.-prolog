:- dynamic leitor/3.

livro(1, "vidas secas","graciliano ramos","romance").
livro(2, "1984", "george orwell", "distopia").
livro(3, "a breve história do tempo", "stephen hawking", "não-ficção").
livro(4, "o código da vinci", "dan brown", "suspense").
livro(5, "a revolução dos bichos", "george orwell", "fábula").
livro(6, "harry potter e a pedra filosofal", "j.k. rowling", "fantasia").
livro(7, "orgulho e preconceito", "jane austen", "romance").
livro(8, "moby dick", "herman melville", "aventura").
livro(9, "sapiens", "yuval noah harari", "história").
livro(10, "angustia","graciliano ramos","romance").

leitor("Eduardo",1,[[7,8],[1,9],[9,7]]).
leitor("Lucas",2,[[5,9],[1,4],[8,1]]).
leitor("Lua",3,[[10,6],[6,7],[3,9]]).
leitor("Caio",4,[[6,5],[9,5],[2,10]]).
leitor("vinicius",5,[[4,3],[10,10],[8,10]]).

listar_livros_autor(Autor,Livros) :-
    findall(Titulo, livro(_,Titulo,Autor,_), Livros).

calcular_media_livro(Titulo, Media):-
    livro(IdLivro, Titulo, _, _),
    findall(Nota, (leitor(_, _, Avaliacoes), member([IdLivro, Nota], Avaliacoes)), Notas),
    Notas \=[],
    sum_list(Notas, Soma),
    length(Notas, N),
    Media is Soma / N.

atualizar_avaliacoes([], _, _, []).
atualizar_avaliacoes([[IdLivro, _]|T], IdLivro, NovaNota, [[IdLivro, NovaNota]|T]).
atualizar_avaliacoes([H|T], IdLivro, NovaNota, [H|R]) :-
    atualizar_avaliacoes(T, IdLivro, NovaNota, R).

atualizar_nota(IdCliente,Titulo,NovaNota):-
    livro(IdLivro,Titulo,_,_),
    retract(leitor(Nome,IdCliente,Avaliacoes)),
    atualizar_avaliacoes(Avaliacoes, IdLivro, NovaNota, NovasAvaliacoes),
    assert(leitor(Nome, IdCliente, NovasAvaliacoes)).

leitores_avaliacao_alta(Titulo, NotaMinima, Leitores) :-
    livro(IdLivro, Titulo, _, _),
    findall(Nome,
        (leitor(Nome, _, Avaliacoes), member([IdLivro, Nota], Avaliacoes), Nota >= NotaMinima), 
        Leitores).