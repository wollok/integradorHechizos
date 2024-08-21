class Casa {
  var property opuesta
  var property puntaje
}

object grifindor inherits Casa(opuesta=slyterin,puntaje=3){
  method consideraPeligroso(estudiante) = false
}

object slyterin{
  method consideraPeligroso(estudiante) = true
  method puntaje() = 4
  method opuesta() = grifindor

}

object ravenclow{
    method consideraPeligroso(estudiante) = estudiante.habilidoso()
    method puntaje() = 1
    method opuesta() = huple

}

object huple{
    method consideraPeligroso(estudiante) = estudiante.sangrePura()
    method puntaje() = 1
    method opuesta() = ravenclow
}


class Materia {
    var property profesor
    const estudiantes = []

    method inscribir(e){ estudiantes.add(e)}
    method darDeBaja(e){ estudiantes.remove(e)}
    
    method dictar(){
      estudiantes.forEach{e=>
        e.aprender(profesor.hechizo()) 
        e.aumentaHabilidad()}
    }
    method practicar(destinatario){
      estudiantes.forEach{e=>
        e.lanzar(profesor.hechizo(),destinatario)}
    }

}

class Profesor inherits Estudiante{
  var property hechizo
}


class Estudiante inherits Personaje{
  const hechizos = [] 
  var property habilidad
  var casa
  var property sangrePura = false

  method habiloso() = habilidad > 10 

  method irCasaOpuesta() {
    casa = casa.opuesta()
  }

  method aumentarHabilidad(){
    habilidad = habilidad + casa.puntaje()
  }
  method esPeligroso() = salud > 0 and casa.consideraPeligroso(self)
  method lanzar(hechizo,destinatario){
    if (self.puedeLanzar(hechizo)){
        hechizo.consecuencias(destinatario)
        hechizo.pagarCosto(self)
    }
  }
  method puedeLanzar(hechizo) = 
     hechizos.contains(hechizo) and hechizo.estaHabilitado(self)
}

class Hechizo {
  var dificultad 
  method consecuencias(destinatario){
      destinatario.disminuirSalud(self.danio())
  }
  method estaHabilitado(estudiante) =
    estudiante.habilidad() > dificultad

  method pagarCosto(estudiante) {}

  method danio() = dificultad * 0.8 + 10

}

class HechizoPeligroso inherits Hechizo{

  override method estaHabilitado(estudiante) =
    not estudiante.esPeligroso()
  
  override method pagarCosto(estudiante){
    estudiante.disminuirHabilidad(1)
  }
}

class HechizoImperdonable inherits Hechizo{
  var costo
  override method danio() = super() * 2
    
  override method pagarCosto(estudiante) {
    estudiante.disminuirSalud(costo)
  }
}

class HechizoInventado inherits Hechizo{
    
  override method estaHabilitado(estudiante) =
    estudiante.sangrePura()

  override method pagarCosto(estudiante) {
    estudiante.irCasaOpuesta()
  }
}

class Personaje{
   var salud = 100

   method disminuirSalud(cant){
     salud = salud - cant
   }
   method salud() = salud

}

class Inmune inherits Personaje{
  
   override method disminuirSalud(cant){
   }

}