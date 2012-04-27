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

public class JSNameValuePairNode extends JSNode
{
	private Symbol _colon;

	/**
	 * JSNameValuePairNode
	 * 
	 * @param name
	 * @param colon
	 * @param value
	 */
	public JSNameValuePairNode(JSNode name, Symbol colon, JSNode value)
	{
		super(IJSNodeTypes.NAME_VALUE_PAIR, name, value);

		this._colon = colon;
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
	 * getColon
	 * 
	 * @return
	 */
	public Symbol getColon()
	{
		return this._colon;
	}

	/**
	 * getName
	 */
	public IParseNode getName()
	{
		return this.getChild(0);
	}

	/**
	 * getValue
	 * 
	 * @return
	 */
	public IParseNode getValue()
	{
		return this.getChild(1);
	}
}
