package lang.ast;

import lang.interpreter.Visitor;

public class IntType extends Type{
	public IntType(int line, int col) {
		super(line, col);
	}

	@Override
	public String toString() {
		return "Int";
	}

	@Override
	public void accept(Visitor v) {
		v.visit(this);
	}
}