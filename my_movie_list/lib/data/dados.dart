import '../models/usuario.dart';
import '../models/filme.dart';

const USUARIOS_CADASTRADOS = [
  Usuario(nome: "John Doe",  senha: "123"),
  Usuario(nome: "Peter Parker", senha: "spiderman101"),
  Usuario(nome: "Luke Skywalker",  senha: "jedi123")
];

var FILMES = [
  Filme(
    titulo: "Homem-Aranha: Através do Aranhaverso", 
    descricao: "Miles Morales, o amigão da vizinhança Homem-Aranha, é transporado através do multiverso para unir forças com Gwen Stacy e um novo time de Pessoas-Aranha para enfrentar um vilão mais poderoso.",
    imagem: "assets/images/spiderverse.jpg",
    genero: [
      "Animação", 
      "Ação", 
      "Aventura"
    ]
  ),
  Filme(
    titulo: "Barbie",
    descricao: "Viver na Terra da Barbie é ser um ser perfeito em um lugar perfeito. A menos que você tenha uma crise existencial completa. Ou que você seja um Ken.",
    imagem: "assets/images/barbie.jpg",
    genero: [
      "Aventura",
      "Comédia",
      "Fantasia"
    ]
  ),
  Filme(
    titulo: "Openheimer",
    descricao: "A história do cientista americano J. Robert Oppenheimer e o seu papel no desenvolvimento da bomba atômica.",
    imagem: "assets/images/openheimer.jpg",
    genero: [
      "Biografia",
      "Drama",
      "História"
    ]
  ),
  Filme(
    titulo: "John Wick 4: Baba Yaga",
    descricao: "John Wick descobre um modo para derrotar a Alta Cúpula. Mas, antes que possa conquistar a sua liberdade, Wick deve enfrentar um novo inimigo com alianças poderosas no mundo todo.",
    imagem: "assets/images/john_wick.jpg",
    genero: [
      "Ação",
      "Policial",
      "Suspense"
    ]
  ),
  Filme(
    titulo: "Guardiões da Galáxia Vol. 3",
    descricao: "Após a perda de Gamora, Peter Quill ainda está chateado e deve reunir os Guardiões da Galáxia em uma missão para defender o universo e proteger Rocket.",
    imagem: "assets/images/guardians.jpg",
    genero: [
      "Ação",
      "Aventura",
      "Comédia"
    ]
  ),
  Filme(
    titulo: "Pânico VI",
    descricao: "Os sobreviventes dos assassinatos de Ghostface deixam Woodsboro para trás e iniciam um novo capítulo na cidade de Nova York.",
    imagem: "assets/images/scream_vi",
    genero: [
      "Terror",
      "Mistério",
      "Suspense"
    ]
  )
];

// Depois adicionar um database pros filmes
