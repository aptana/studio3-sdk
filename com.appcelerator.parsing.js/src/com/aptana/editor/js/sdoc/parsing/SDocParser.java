// $codepro.audit.disable
/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.editor.js.sdoc.parsing;

import java.util.ArrayList;
import java.util.List;

import beaver.Parser;
import beaver.ParsingTables;
import beaver.Scanner;
import beaver.Symbol;

import com.aptana.editor.js.sdoc.model.AdvancedTag;
import com.aptana.editor.js.sdoc.model.AliasTag;
import com.aptana.editor.js.sdoc.model.ArrayType;
import com.aptana.editor.js.sdoc.model.AuthorTag;
import com.aptana.editor.js.sdoc.model.ClassDescriptionTag;
import com.aptana.editor.js.sdoc.model.ClassType;
import com.aptana.editor.js.sdoc.model.ConstructorTag;
import com.aptana.editor.js.sdoc.model.DocumentationBlock;
import com.aptana.editor.js.sdoc.model.ExampleTag;
import com.aptana.editor.js.sdoc.model.ExceptionTag;
import com.aptana.editor.js.sdoc.model.ExtendsTag;
import com.aptana.editor.js.sdoc.model.FunctionType;
import com.aptana.editor.js.sdoc.model.InternalTag;
import com.aptana.editor.js.sdoc.model.MethodTag;
import com.aptana.editor.js.sdoc.model.NamespaceTag;
import com.aptana.editor.js.sdoc.model.OverviewTag;
import com.aptana.editor.js.sdoc.model.ParamTag;
import com.aptana.editor.js.sdoc.model.Parameter;
import com.aptana.editor.js.sdoc.model.PrivateTag;
import com.aptana.editor.js.sdoc.model.PropertyTag;
import com.aptana.editor.js.sdoc.model.ReturnTag;
import com.aptana.editor.js.sdoc.model.SeeTag;
import com.aptana.editor.js.sdoc.model.Tag;
import com.aptana.editor.js.sdoc.model.Type;
import com.aptana.editor.js.sdoc.model.TypeTag;
import com.aptana.editor.js.sdoc.model.UnknownTag;
import com.aptana.editor.js.sdoc.model.Usage;

/**
 * This class is a LALR parser generated by
 * <a href="http://beaver.sourceforge.net">Beaver</a> v0.9.6.1
 * from the grammar specification "SDoc.grammar".
 */
@SuppressWarnings({ "unchecked", "nls" })
public class SDocParser extends Parser {
	static public class AltGoals {
		static public final short Types = 42;
	}

	static final ParsingTables PARSING_TABLES = new ParsingTables(
		"U9pjLbbmL4KKFU$DJ2PWI889X0Y6a8GiXc4IaX0ZieXi1Z4ODn0N58q8WajKK1JYnYgKfN$" +
		"gdrPPLgdbXwMMWeYe8A8IKP55N2AYE0eY4GMXFTtlvj4p3XhzeugPElUSk$IT#$fj0xYJCG" +
		"B3C1HdOmZEmLaOZf5m4LMlAOK#E1szCGuNOpAknOsOYtln80PZ5CPW8Xfn5QRY1jo9#x44W" +
		"vBqqUlx8sIuh9DzEbTLtScwvKccEXavqIDXL210gw#hWUeeKf2DT7GLcyjCFb8btmF5w1AN" +
		"BsIcBmRGdeipQMjnMLpUizxgC4gGHnj4Mj8QtI4F5#8qgahwNdmPrSCunVV3w9Qmpbu$0PF" +
		"4hnE#00tiSGMgJ3uJLqhTrSWmKsdl9bnZwhI#1Ksu6QTYdf$Dmcp3BPZZnnRX7ixQ7QL#f1" +
		"Zt6Lril3kmM8vdAOfeRqM4$cXYB74#SH6ZURWKKwYdcvt9mKp3URWR2nXzWAed5g8Nx$f#Q" +
		"4O1EOGpK8wGEgB#H8qwnAFKt$DGZ$6eKwlKIlKw$KjOTpan3TVXUlepg6VXDjoEkwZc4tLu" +
		"YBP67OR39rI0voJ4Cn$ccUx2kx#MauFxdCuzwiwzoE9Uzk0iEPmbb#UdjpdIF9xvV4vMmAk" +
		"WA4aVRtt5V#hJsL$x$rETZ9puaJBU1OvSL#2TrPNFXpIncSnaiDhBwrN1l#KpZItdSyl1GF" +
		"QtyvxrLZjyuqPeemc$qL6ZEqJO8Igzl7WbLHMV0uvVLvAmpbwl9$3ySgkgabDLcNoG#Owwa" +
		"9bAUwwiqZf47UOShfyjaJMwobuHuLHHFv8YsHJZbSeQxtWYxEWTbOq8lr69wvqPHDq$BXhX" +
		"l7fr1NEbXhNIh3#LHBdv1lYlmoMxvglz2a6rxzUmLz3FUB5AqsT5Yo57UsdakSHKOfx4cuX" +
		"PeXSIyubbuhSI6qKl9TQAdW6uHQ8d2I$NjYK1Z4yX3XBJnN#49Z##XiyUE8U9cLBp937Hqs" +
		"urJQ7YXxg6UZ2vLjRD5fwJ#Bl$1A4bnAF44#p79xYpcZo4$jF4yzH3YM74SFelophMO3rZ8" +
		"rZFEcS1$LQPSoJzPuaDTBP9VPjmJ6f6CR#PF9PEk#IECXPcR1pvEM8hiOF8F3Ql6oBgHO#t" +
		"zZPNOXEeNoJQY0A9DL2$IiI8SgddNZhwk1h9Audzn1Z9DLZxKyyQSrwvxPibFmtI8$cUEat" +
		"7YRzYwPYbZmWtwtEVPDrxn27EuOY$dL3nDQwEw#iY93KxgGDM3tsjFzwnXrQyKMBTairyF7" +
		"ZxwwQJTv4pf4Ugv7PJPoNKDml$m5oEfRF9ZrbrUnZhINvA$6U4Nx2EDLjYBmdlPQolw7tKV" +
		"OXUrAiwSHnhB7s0w$gHrrcnTiOAoPl4r#UXpDB5v2tYRxTcBFOOAs1zr1R5QrvzB5wh#f1s" +
		"az4Vg8sq7n7l6t#3#bHzeZwZujbNwqridLghtYA$IxnZ8c$7TVzPnTGUzQFwGnrKlwbsTK3" +
		"zglQhNzG#jLVzpZptMttlL#yMZgdlQ7VvthU#QYE#8Rxs8r$HVkbtYAcTQerHRn9lgDMCVE" +
		"7dTlYArwlQvdjRYS$LJz9aDFypEeJBfvd3Vv01GT2yUmQOjzs$eygyz$Ix3eHZteF744hGY" +
		"Rxcb2HvZwES9ygU5OA8GS2yipmEI2nevK8MXoMNGgJolUOOr1W4VAucTw3kBt1CxeW=");

	// suppress parser error reporting and let the custom error recovery mechanism handle it
	private static class SDocEvents extends Events
	{
		public void scannerError(Scanner.Exception e)
		{
		}

		public void syntaxError(Symbol token)
		{
		}

		public void unexpectedTokenRemoved(Symbol token)
		{
		}

		public void missingTokenInserted(Symbol token)
		{
		}

		public void misspelledTokenReplaced(Symbol token)
		{
		}

		public void errorPhraseRemoved(Symbol error)
		{
		}
	}

	/**
	 * parse
	 *
	 * @param source
	 */
	public Object parse(String source) throws java.lang.Exception
	{
		return parse(source, 0);
	}

	/**
	 * parse
	 *
	 * @param source
	 * @param offset
	 */
	public Object parse(String source, int offset) throws java.lang.Exception
	{
		// SDocScanner fScanner = new SDocScanner();
		SDocFlexScanner fScanner = new SDocFlexScanner();

		fScanner.setOffset(offset);
		fScanner.setSource(source);

		return parse(fScanner);
	}

	/**
	 * parseType
	 * 
	 * @param source
	 * @return
	 * @throws java.lang.Exception
	 */
	public List<Type> parseType(String source) throws java.lang.Exception
	{
		// SDocScanner fScanner = new SDocScanner();
		SDocFlexScanner fScanner = new SDocFlexScanner();

		fScanner.setOffset(0);
		fScanner.setSource(source);
		// fScanner.queueTypeTokens(0, source.length());

		// NOTE: we need to clear the scanner source since queueTypeTokens doesn't set the offset of one of the inner
		// scanners resulting in double scanning
		// fScanner.setSource(StringUtil.EMPTY);

		fScanner.yybegin(SDocFlexScanner.TYPES);

		Object result = parse(fScanner, AltGoals.Types);

		return (result instanceof List) ? (List<Type>) result : null;
	}

	public SDocParser() {
		super(PARSING_TABLES);


	report = new SDocEvents();
	}

	protected Symbol invokeReduceAction(int rule_num, int offset) {
		switch(rule_num) {
			case 3: // Block = START_DOCUMENTATION Text.text END_DOCUMENTATION
			{
					final Symbol text = _symbols[offset + 2];
					
			return new DocumentationBlock((String) text.value);
			}
			case 4: // Block = START_DOCUMENTATION Tags.tags END_DOCUMENTATION
			{
					final Symbol tags = _symbols[offset + 2];
					
			return new DocumentationBlock((List<Tag>) tags.value);
			}
			case 5: // Block = START_DOCUMENTATION Text.text Tags.tags END_DOCUMENTATION
			{
					final Symbol text = _symbols[offset + 2];
					final Symbol tags = _symbols[offset + 3];
					
			return new DocumentationBlock((String) text.value, (List<Tag>) tags.value);
			}
			case 6: // Text = Text.text TextPart.part
			{
					final Symbol text = _symbols[offset + 1];
					final Symbol part = _symbols[offset + 2];
					
			return new Symbol(text.value + " " + part.value);
			}
			case 17: // Tags = Tags.tags Tag.tag
			{
					final Symbol tags = _symbols[offset + 1];
					final Symbol _symbol_tag = _symbols[offset + 2];
					final Tag tag = (Tag) _symbol_tag.value;
					
			((List<Tag>) tags.value).add(tag);

			return tags;
			}
			case 18: // Tags = Tag.tag
			{
					final Symbol _symbol_tag = _symbols[offset + 1];
					final Tag tag = (Tag) _symbol_tag.value;
					
			List<Tag> tags = new ArrayList<Tag>();

			tags.add(tag);

			return new Symbol(tags);
			}
			case 21: // Tag = ADVANCED opt$Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new AdvancedTag((String) text.value);
			}
			case 22: // Tag = ALIAS Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new AliasTag((String) text.value);
			}
			case 23: // Tag = AUTHOR Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new AuthorTag((String) text.value);
			}
			case 24: // Tag = CLASS_DESCRIPTION LCURLY Namespace.name RCURLY Text.text
			{
					final Symbol _symbol_name = _symbols[offset + 3];
					final String name = (String) _symbol_name.value;
					final Symbol text = _symbols[offset + 5];
					
			return new ClassDescriptionTag(name, (String) text.value);
			}
			case 25: // Tag = CONSTRUCTOR opt$Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new ConstructorTag((String) text.value);
			}
			case 26: // Tag = EXAMPLE Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new ExampleTag((String) text.value);
			}
			case 27: // Tag = EXCEPTION LCURLY Types.types RCURLY opt$Text.text
			{
					final Symbol types = _symbols[offset + 3];
					final Symbol text = _symbols[offset + 5];
					
			return new ExceptionTag((List<Type>) types.value, (String) text.value);
			}
			case 28: // Tag = EXTENDS LCURLY Types.types RCURLY opt$Text.text
			{
					final Symbol types = _symbols[offset + 3];
					final Symbol text = _symbols[offset + 5];
					
			return new ExtendsTag((List<Type>) types.value, (String) text.value);
			}
			case 29: // Tag = INTERNAL opt$Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new InternalTag((String) text.value);
			}
			case 30: // Tag = METHOD opt$Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new MethodTag((String) text.value);
			}
			case 31: // Tag = NAMESPACE LCURLY Namespace.name RCURLY opt$Text.text
			{
					final Symbol _symbol_name = _symbols[offset + 3];
					final String name = (String) _symbol_name.value;
					final Symbol text = _symbols[offset + 5];
					
			return new NamespaceTag(name, (String) text.value);
			}
			case 32: // Tag = OVERVIEW Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new OverviewTag((String) text.value);
			}
			case 33: // Tag = PARAM LCURLY Types.types RCURLY ParamName.name opt$Text.text
			{
					final Symbol types = _symbols[offset + 3];
					final Symbol _symbol_name = _symbols[offset + 5];
					final Parameter name = (Parameter) _symbol_name.value;
					final Symbol text = _symbols[offset + 6];
					
			return new ParamTag(name, (List<Type>) types.value, (String) text.value);
			}
			case 34: // Tag = PRIVATE opt$Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new PrivateTag((String) text.value);
			}
			case 35: // Tag = PROPERTY LCURLY Types.types RCURLY opt$Text.text
			{
					final Symbol types = _symbols[offset + 3];
					final Symbol text = _symbols[offset + 5];
					
			return new PropertyTag((List<Type>) types.value, (String) text.value);
			}
			case 36: // Tag = RETURN LCURLY Types.types RCURLY opt$Text.text
			{
					final Symbol types = _symbols[offset + 3];
					final Symbol text = _symbols[offset + 5];
					
			return new ReturnTag((List<Type>) types.value, (String) text.value);
			}
			case 37: // Tag = SEE Text.text
			{
					final Symbol text = _symbols[offset + 2];
					
			return new SeeTag((String) text.value);
			}
			case 38: // Tag = TYPE LCURLY Types.types RCURLY opt$Text.text
			{
					final Symbol types = _symbols[offset + 3];
					final Symbol text = _symbols[offset + 5];
					
			return new TypeTag((List<Type>) types.value, (String) text.value);
			}
			case 39: // Tag = UNKNOWN.name opt$Text.text
			{
					final Symbol _symbol_name = _symbols[offset + 1];
					final String name = (String) _symbol_name.value;
					final Symbol text = _symbols[offset + 2];
					
			return new UnknownTag(name, (String) text.value);
			}
			case 40: // Types = Types.types TypeDelimiter Type.type
			{
					final Symbol types = _symbols[offset + 1];
					final Symbol _symbol_type = _symbols[offset + 3];
					final Type type = (Type) _symbol_type.value;
					
			((List<Type>) types.value).add(type);

			return types;
			}
			case 41: // Types = Type.type
			{
					final Symbol _symbol_type = _symbols[offset + 1];
					final Type type = (Type) _symbol_type.value;
					
			List<Type> types = new ArrayList<Type>();

			types.add(type);

			return new Symbol(types);
			}
			case 44: // Type = IDENTIFIER.name
			{
					final Symbol _symbol_name = _symbols[offset + 1];
					final String name = (String) _symbol_name.value;
					
			return new Type(name);
			}
			case 45: // Type = IDENTIFIER.name LBRACKET RBRACKET
			{
					final Symbol _symbol_name = _symbols[offset + 1];
					final String name = (String) _symbol_name.value;
					
			return new ArrayType(new Type(name));
			}
			case 46: // Type = CLASS LESS_THAN Type.memberType GREATER_THAN
			{
					final Symbol _symbol_memberType = _symbols[offset + 3];
					final Type memberType = (Type) _symbol_memberType.value;
					
			return new ClassType(memberType);
			}
			case 47: // Type = ARRAY LBRACKET RBRACKET
			{
					
			return new ArrayType();
			}
			case 48: // Type = FUNCTION LBRACKET RBRACKET
			{
					
			return new FunctionType();
			}
			case 49: // Type = ARRAY
			{
					
			return new ArrayType();
			}
			case 50: // Type = ARRAY LESS_THAN Type.memberType GREATER_THAN
			{
					final Symbol _symbol_memberType = _symbols[offset + 3];
					final Type memberType = (Type) _symbol_memberType.value;
					
			return new ArrayType(memberType);
			}
			case 51: // Type = FUNCTION
			{
					
			return new FunctionType();
			}
			case 52: // Type = FUNCTION ReturnDelimiter Type.returnType
			{
					final Symbol _symbol_returnType = _symbols[offset + 3];
					final Type returnType = (Type) _symbol_returnType.value;
					
			FunctionType function = new FunctionType();

			function.addReturnType(returnType);

			return function;
			}
			case 53: // Type = FUNCTION ReturnDelimiter LPAREN Types.returnTypes RPAREN
			{
					final Symbol returnTypes = _symbols[offset + 4];
					
			FunctionType function = new FunctionType();

			for (Type returnType : (List<Type>) returnTypes.value)
			{
				function.addReturnType(returnType);
			}

			return function;
			}
			case 54: // Type = FUNCTION LPAREN RPAREN
			{
					
			return new FunctionType();
			}
			case 55: // Type = FUNCTION LPAREN RPAREN ReturnDelimiter Type.returnType
			{
					final Symbol _symbol_returnType = _symbols[offset + 5];
					final Type returnType = (Type) _symbol_returnType.value;
					
			FunctionType function = new FunctionType();

			function.addReturnType(returnType);

			return function;
			}
			case 56: // Type = FUNCTION LPAREN RPAREN ReturnDelimiter LPAREN Types.returnTypes RPAREN
			{
					final Symbol returnTypes = _symbols[offset + 6];
					
			FunctionType function = new FunctionType();

			for (Type returnType : (List<Type>) returnTypes.value)
			{
				function.addReturnType(returnType);
			}

			return function;
			}
			case 57: // Type = FUNCTION LPAREN Types.parameterTypes RPAREN
			{
					final Symbol parameterTypes = _symbols[offset + 3];
					
			FunctionType function = new FunctionType();

			for (Type parameterType : (List<Type>) parameterTypes.value)
			{
				function.addParameterType(parameterType);
			}

			return function;
			}
			case 58: // Type = FUNCTION LPAREN Types.parameterTypes RPAREN ReturnDelimiter Type.returnType
			{
					final Symbol parameterTypes = _symbols[offset + 3];
					final Symbol _symbol_returnType = _symbols[offset + 6];
					final Type returnType = (Type) _symbol_returnType.value;
					
			FunctionType function = new FunctionType();

			for (Type parameterType : (List<Type>) parameterTypes.value)
			{
				function.addParameterType(parameterType);
			}

			function.addReturnType(returnType);

			return function;
			}
			case 59: // Type = FUNCTION LPAREN Types.parameterTypes RPAREN ReturnDelimiter LPAREN Types.returnTypes RPAREN
			{
					final Symbol parameterTypes = _symbols[offset + 3];
					final Symbol returnTypes = _symbols[offset + 7];
					
			FunctionType function = new FunctionType();

			for (Type parameterType : (List<Type>) parameterTypes.value)
			{
				function.addParameterType(parameterType);
			}

			for (Type returnType : (List<Type>) returnTypes.value)
			{
				function.addReturnType(returnType);
			}

			return function;
			}
			case 62: // ParamName = TEXT.name
			{
					final Symbol _symbol_name = _symbols[offset + 1];
					final String name = (String) _symbol_name.value;
					
			return new Parameter(name);
			}
			case 63: // ParamName = LBRACKET TEXT.name RBRACKET
			{
					final Symbol _symbol_name = _symbols[offset + 2];
					final String name = (String) _symbol_name.value;
					
			Parameter result = new Parameter(name);

			result.setUsage(Usage.OPTIONAL);

			return result;
			}
			case 64: // ParamName = ELLIPSIS
			{
					
			Parameter result = new Parameter("...");

			result.setUsage(Usage.ONE_OR_MORE);

			return result;
			}
			case 65: // ParamName = LBRACKET ELLIPSIS RBRACKET
			{
					
			Parameter result = new Parameter("...");

			result.setUsage(Usage.ZERO_OR_MORE);

			return result;
			}
			case 19: // opt$Text = 
			{
				return new Symbol(null);
			}
			case 0: // $goal = Grammar
			case 2: // Grammar = Block
			case 7: // Text = TextPart
			case 8: // TextPart = TEXT
			case 9: // TextPart = LBRACKET
			case 10: // TextPart = RBRACKET
			case 11: // TextPart = LCURLY
			case 12: // TextPart = RCURLY
			case 13: // TextPart = POUND
			case 14: // TextPart = IDENTIFIER
			case 15: // TextPart = COLON
			case 16: // TextPart = ERROR
			case 20: // opt$Text = Text
			case 42: // TypeDelimiter = COMMA
			case 43: // TypeDelimiter = PIPE
			case 60: // ReturnDelimiter = COLON
			case 61: // ReturnDelimiter = ARROW
			case 66: // Namespace = IDENTIFIER
			case 67: // Namespace = FUNCTION
			case 68: // Namespace = ARRAY
			{
				return _symbols[offset + 1];
			}
			case 1: // $goal = $Types Types
			{
				return _symbols[offset + 2];
			}
			default:
				throw new IllegalArgumentException("unknown production #" + rule_num);
		}
	}
}