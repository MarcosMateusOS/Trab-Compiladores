package lang.ast;

import lang.interpreter.Visitor;

public class NewTypeExp extends Exp {
	private Exp exp;
	private Type type;
	private String dataName;

	public NewTypeExp(int line, int col, Exp exp, Type type, String dataName) {
		super(line, col);

		this.exp = exp;
		this.type = type;
		this.dataName = dataName;
	}
	
	public NewTypeExp(int line, int col,  Type type, String dataName) {
		super(line, col);

		
		this.type = type;
		this.dataName = dataName;
	}


	@Override
	public String toString() {
		if (type != null) {
			return " new " + type + (exp != null ? (" [ " + exp + " ] ") : " ");
		} else
			return " new " + dataName + (exp != null ? (" [ " + exp + " ] ") : " ");

	}

	@Override
	public void accept(Visitor v) {
		v.visit(this);
	}

}