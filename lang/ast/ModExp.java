package lang.ast;

import lang.interpreter.Visitor;

//Regra: |<assoc=left> mexp MOD_SIGN sexp               #ModExp
public class ModExp extends BinOp {

	public ModExp(int line, int col, Exp left, Exp right) {
		super(line, col, left, right);
	}

	@Override
	public String toString() {
		return (left.toString() + " % " + right.toString());
	}

	@Override
	public void accept(Visitor v) {
		v.visit(this);
	}

}