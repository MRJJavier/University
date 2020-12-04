
public class DosEtiquetas {

	private String v;
	private String f;
	
	public DosEtiquetas() {
		v = Generador.nuevaEtiqueta();
		f = Generador.nuevaEtiqueta();
	}
	
	public DosEtiquetas(String v, String f) {
		this.v = v;
		this.f = f;
	}
	
	public String v() {
		return v;
	}

	public String f() {
		return f;
	}

	public String inicio() {
		return v;
	}

	public String fin() {
		return f;
	}


}
