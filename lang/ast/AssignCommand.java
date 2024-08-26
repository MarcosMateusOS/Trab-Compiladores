package lang.ast;

import java.util.ArrayList;
import java.util.List;

import lang.interpreter.Visitor;

public class AssignCommand extends Command {
    private Exp exp;
    private LValue lvalue;


    
    public AssignCommand(int line, int col, Exp exp, LValue lvalue) {
        super(line, col);
        this.exp = exp;
        this.lvalue = lvalue;
    }


    @Override
    public String toString() {
    	return this.lvalue.toString() + " = " + this.exp.toString() + " ; " ;
    }

    @Override
    public void accept(Visitor v) {
        v.visit(this);
    }
}