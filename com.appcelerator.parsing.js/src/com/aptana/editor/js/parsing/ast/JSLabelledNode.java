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

public class JSLabelledNode extends JSNode
{
	private Symbol _colon;

	/**
	 * JSLabelledNode
	 * 
	 * @param children
	 */
	public JSLabelledNode(JSNode label, Symbol colon, JSNode block)
	{
		super(IJSNodeTypes.LABELLED, label, block);

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
	 * getBlock
	 * 
	 * @return
	 */
	public IParseNode getBlock()
	{
		return this.getChild(1);
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
	 * getLabel
	 * 
	 * @return
	 */
	public IParseNode getLabel()
	{
		return this.getChild(0);
	}
}
