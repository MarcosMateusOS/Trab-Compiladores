package lang.ast;

import lang.interpreter.Visitor;



public abstract class LValue extends Exp {

	public abstract String getID();

	public LValue(int line, int col) {
		super(line, col);
	}
	
	@Override
    public void accept(Visitor v) {
        v.visit(this);
    }

}
