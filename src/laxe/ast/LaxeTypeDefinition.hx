package laxe.ast;

import haxe.macro.Context;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.TypeDefinition;

@:nullSafety(Strict)
@:forward
abstract LaxeTypeDefinition(TypeDefinition) from TypeDefinition to TypeDefinition {
	public inline function new(t: TypeDefinition) {
		this = t;
	}

	public function getAllExpr(): Array<LaxeExpr> {
		final result: Array<LaxeExpr> = [];
		if(this.fields != null && this.fields.length > 0) {
			for(f in this.fields) {
				final e = (f : LaxeField).getExpr();
				if(e != null) {
					result.push(e);
				}
			}
		}
		return result;
	}

	public inline function addVar(name: String, expr: Null<LaxeExpr> = null, type: Null<ComplexType> = null) {
		this.fields.push({
			name: name,
			pos: expr != null ? expr.pos : this.pos,
			kind: FVar(type, expr),
			access: [APublic]
		});
	}

	public inline function addFunction(expr: LaxeExpr, name: Null<String> = null) {
		switch(expr.expr) {
			case EFunction(kind, f): {
				final name = switch(kind) {
					case FNamed(name, _): name;
					case _: name;
				}
				#if macro
				if(name == null) {
					Context.error("Unable to determine function name", expr.pos);
					return;
				}
				#end
				this.fields.push({
					name: name != null ? name : "unnamed",
					pos: expr.pos,
					kind: FFun(f),
					access: [APublic]
				});
			}
			case _:
		}
	}

	public inline function isEnum(): Bool {
		return switch(this.kind) {
			case TDEnum: true;
			case _: false;
		}
	}

	public inline function isStructure(): Bool {
		return switch(this.kind) {
			case TDStructure: true;
			case _: false;
		}
	}

	public inline function isClass(): Bool {
		return switch(this.kind) {
			case TDClass(_, _, _, _, _): true;
			case _: false;
		}
	}

	public inline function getClass() {
		return switch(this.kind) {
			case TDClass(superClass, interfaces, isInterface, isFinal, isAbstract): {
				superClass: superClass,
				interfaces: interfaces,
				isInterface: isInterface,
				isFinal: isFinal,
				isAbstract: isAbstract
			}
			case _: throw "Not a TDClass";
		}
	}

	public inline function isTypedef(): Bool {
		return switch(this.kind) {
			case TDAlias(_): true;
			case _: false;
		}
	}

	public inline function getTypedef() {
		return switch(this.kind) {
			case TDAlias(t): t;
			case _: throw "Not a TDAlias";
		}
	}

	public inline function isWrapper(): Bool {
		return switch(this.kind) {
			case TDAbstract(_, _, _): true;
			case _: false;
		}
	}

	public inline function getWrapper() {
		return switch(this.kind) {
			case TDAbstract(tthis, from, to): {
				tthis: tthis,
				from: from,
				to: to
			};
			case _: throw "Not a TDAbstract";
		}
	}

	public inline function isField(): Bool {
		return switch(this.kind) {
			case TDField(_, _): true;
			case _: false;
		}
	}

	public inline function getField() {
		return switch(this.kind) {
			case TDField(kind, access): {
				kind: kind,
				access: access
			};
			case _: throw "Not a TDField";
		}
	}
}
