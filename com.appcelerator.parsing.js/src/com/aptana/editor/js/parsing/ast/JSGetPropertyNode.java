/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.editor.js.parsing.ast;

import beaver.Symbol;

public class JSGetPropertyNode extends JSBinaryOperatorNode
{
	/**
	 * JSGetPropertyOperatorNode
	 * 
	 * @param left
	 * @param right
	 */
	public JSGetPropertyNode(JSNode left, Symbol operator, JSNode right)
	{
		super(left, operator, right);

		this.setNodeType(IJSNodeTypes.GET_PROPERTY);
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
}
