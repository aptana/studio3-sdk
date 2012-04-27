/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.editor.js.parsing.ast;

import beaver.Symbol;

import com.aptana.parsing.ast.IParseNode;

public class JSSwitchNode extends JSNode
{
	private Symbol _leftParenthesis;
	private Symbol _rightParenthesis;
	private Symbol _leftBrace;
	private Symbol _rightBrace;

	/**
	 * JSSwitchNode
	 * 
	 * @param leftParenthesis
	 * @param expression
	 * @param rightParenthesis
	 * @param leftBrace
	 * @param rightBrace
	 * @param children
	 */
	public JSSwitchNode(Symbol leftParenthesis, JSNode expression, Symbol rightParenthesis, Symbol leftBrace,
			Symbol rightBrace, JSNode... children)
	{
		super(IJSNodeTypes.SWITCH, expression);

		for (JSNode child : children)
		{
			this.addChild(child);
		}

		this._leftParenthesis = leftParenthesis;
		this._rightParenthesis = rightParenthesis;
		this._leftBrace = leftBrace;
		this._rightBrace = rightBrace;
	}

	/*
	 * (non-Javadoc)
	 * @see com.aptana.editor.js.parsing.ast.JSNode#accept(com.aptana.editor.js.parsing.ast.JSTreeWalker)
	 */
	@Override
	public void accept(JSTreeWalker walker)
	{
		walker.visit(this);
	}

	/**
	 * getExpression
	 * 
	 * @return
	 */
	public IParseNode getExpression()
	{
		return this.getChild(0);
	}

	/**
	 * getLeftBrace
	 * 
	 * @return
	 */
	public Symbol getLeftBrace()
	{
		return this._leftBrace;
	}

	/**
	 * getLeftParenthesis
	 * 
	 * @return
	 */
	public Symbol getLeftParenthesis()
	{
		return this._leftParenthesis;
	}

	/**
	 * getRightBrace
	 * 
	 * @return
	 */
	public Symbol getRightBrace()
	{
		return this._rightBrace;
	}

	/**
	 * getRightParenthesis
	 * 
	 * @return
	 */
	public Symbol getRightParenthesis()
	{
		return this._rightParenthesis;
	}
}
