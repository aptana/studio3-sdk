/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.editor.js.parsing.ast;

public interface IJSNodeTypes
{
	public static final short ERROR = -1;
	public static final short EMPTY = 0;
	public static final short ASSIGN = 1;
	public static final short ADD_AND_ASSIGN = 2;
	public static final short ARITHMETIC_SHIFT_RIGHT_AND_ASSIGN = 3;
	public static final short BITWISE_AND_AND_ASSIGN = 4;
	public static final short BITWISE_OR_AND_ASSIGN = 5;
	public static final short BITWISE_XOR_AND_ASSIGN = 6;
	public static final short DIVIDE_AND_ASSIGN = 7;
	public static final short MOD_AND_ASSIGN = 8;
	public static final short MULTIPLY_AND_ASSIGN = 9;
	public static final short SHIFT_LEFT_AND_ASSIGN = 10;
	public static final short SHIFT_RIGHT_AND_ASSIGN = 11;
	public static final short SUBTRACT_AND_ASSIGN = 12;
	public static final short NULL = 13;
	public static final short TRUE = 14;
	public static final short FALSE = 15;
	public static final short NUMBER = 16;
	public static final short STRING = 17;
	public static final short REGEX = 18;
	public static final short IDENTIFIER = 19;
	public static final short THIS = 20;
	public static final short STATEMENTS = 21;
	public static final short CONTINUE = 22;
	public static final short BREAK = 23;
	public static final short EQUAL = 24;
	public static final short GREATER_THAN = 25;
	public static final short GREATER_THAN_OR_EQUAL = 26;
	public static final short IDENTITY = 27;
	public static final short IN = 28;
	public static final short INSTANCE_OF = 29;
	public static final short LESS_THAN = 30;
	public static final short LESS_THAN_OR_EQUAL = 31;
	public static final short LOGICAL_AND = 32;
	public static final short LOGICAL_OR = 33;
	public static final short NOT_EQUAL = 34;
	public static final short NOT_IDENTITY = 35;
	public static final short ADD = 36;
	public static final short ARITHMETIC_SHIFT_RIGHT = 37;
	public static final short BITWISE_AND = 38;
	public static final short BITWISE_OR = 39;
	public static final short BITWISE_XOR = 40;
	public static final short DIVIDE = 41;
	public static final short MOD = 42;
	public static final short MULTIPLY = 43;
	public static final short SHIFT_LEFT = 44;
	public static final short SHIFT_RIGHT = 45;
	public static final short SUBTRACT = 46;
	public static final short GET_ELEMENT = 47;
	public static final short GET_PROPERTY = 48;
	public static final short DELETE = 49;
	public static final short LOGICAL_NOT = 50;
	public static final short NEGATIVE = 51;
	public static final short PRE_DECREMENT = 52;
	public static final short POSITIVE = 53;
	public static final short PRE_INCREMENT = 54;
	public static final short BITWISE_NOT = 55;
	public static final short TYPEOF = 56;
	public static final short VOID = 57;
	public static final short GROUP = 58;
	public static final short POST_DECREMENT = 59;
	public static final short POST_INCREMENT = 60;
	public static final short ARGUMENTS = 61;
	public static final short INVOKE = 62;
	public static final short DECLARATION = 63;
	public static final short VAR = 64;
	public static final short TRY = 65;
	public static final short CATCH = 66;
	public static final short FINALLY = 67;
	public static final short CONDITIONAL = 68;
	public static final short PARAMETERS = 69;
	public static final short FUNCTION = 70;
	public static final short ELISION = 71;
	public static final short ELEMENTS = 72;
	public static final short ARRAY_LITERAL = 73;
	public static final short COMMA = 74;
	public static final short CONSTRUCT = 75;
	public static final short NAME_VALUE_PAIR = 76;
	public static final short OBJECT_LITERAL = 77;
	public static final short THROW = 78;
	public static final short LABELLED = 79;
	public static final short WHILE = 80;
	public static final short WITH = 81;
	public static final short SWITCH = 82;
	public static final short CASE = 83;
	public static final short DEFAULT = 84;
	public static final short RETURN = 85;
	public static final short IF = 86;
	public static final short DO = 87;
	public static final short FOR = 88;
	public static final short FOR_IN = 89;
	public static final short SDOC_COMMENT = 90;
	public static final short VSDOC_COMMENT = 91;
	public static final short SINGLE_LINE_COMMENT = 92;
	public static final short MULTI_LINE_COMMENT = 93;
}
