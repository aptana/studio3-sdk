/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.parsing.ast;

/**
 * @author Kevin Lindsey
 *
 */
public final class Messages
{
	private Messages()
	{
	}

	public static String ParseError_syntax_error_unexpected_token = "Syntax Error: unexpected token ";
	public static String ParseNode_Bad_Ending_Offset = "Resetting end since it must be greater than or equal to start - 1: start={0}, end={1} (Node Info: language={2}, type={3}, source={4})";
	public static String ParseNodeAttribute_Undefined_Parent = "parent must not be null";
	public static String ParseNodeAttribute_Undefined_Name = "name must not be null";
	public static String ParseNodeAttribute_Undefined_Value = "value must not be null";
	public static String ParseNodeBase_Undefined_Child = "child must not be null";
	public static String ParseNodeFactory_Undefined_Parse_State = "parseState must be defined";
	public static String ParseNodeWalkerBase_Undefined_Node = "node must not be null";
	public static String ParseNodeWalkerGroup_Undefined_Node_Processor = "processor must not be null";
}
