/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.editor.js.parsing.ast;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import com.aptana.editor.js.sdoc.model.DocumentationBlock;
import com.aptana.editor.js.sdoc.model.Tag;
import com.aptana.editor.js.sdoc.model.TagType;
import com.aptana.editor.js.sdoc.model.TagWithTypes;
import com.aptana.editor.js.sdoc.model.Type;
import com.aptana.parsing.ast.IParseNode;
import com.aptana.parsing.ast.IParseNodeAttribute;
import com.aptana.parsing.ast.ParseNode;
import com.aptana.parsing.ast.ParseNodeAttribute;

public class JSFunctionNode extends JSNode
{
	private List<String> fReturnTypes;

	/**
	 * JSFunctionNode
	 * 
	 * @param children
	 */
	public JSFunctionNode(JSNode... children)
	{
		super(IJSNodeTypes.FUNCTION, children);
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

	/*
	 * (non-Javadoc)
	 * @see com.aptana.parsing.ast.ParseBaseNode#getAttributes()
	 */
	public IParseNodeAttribute[] getAttributes()
	{
		String name = this.getName().getText();

		if (name != null && name.length() > 0)
		{
			// TODO: possibly cache this
			return new IParseNodeAttribute[] { new ParseNodeAttribute(this, "name", name) //$NON-NLS-1$
			};
		}
		else
		{
			return ParseNode.NO_ATTRIBUTES;
		}
	}

	/**
	 * getBody
	 * 
	 * @return
	 */
	public IParseNode getBody()
	{
		return this.getChild(2);
	}

	/**
	 * getName
	 * 
	 * @return
	 */
	public IParseNode getName()
	{
		return this.getChild(0);
	}

	/**
	 * getParameters
	 * 
	 * @return
	 */
	public IParseNode getParameters()
	{
		return this.getChild(1);
	}

	/**
	 * getReturnNodes
	 * 
	 * @return
	 */
	public List<JSReturnNode> getReturnNodes()
	{
		List<JSReturnNode> result = new ArrayList<JSReturnNode>();

		// Using a linked list since it provides a queue interface
		Queue<IParseNode> queue = new LinkedList<IParseNode>();

		// prime the queue
		queue.add(this.getBody());

		while (queue.size() > 0)
		{
			IParseNode current = queue.poll();

			if (current instanceof JSReturnNode)
			{
				result.add((JSReturnNode) current);
			}
			else if (!(current instanceof JSFunctionNode))
			{
				for (IParseNode child : current)
				{
					queue.offer(child);
				}
			}
		}

		return result;
	}

	/**
	 * getReturnTypes
	 * 
	 * @return
	 */
	public List<String> getReturnTypes()
	{
		if (fReturnTypes == null)
		{
			fReturnTypes = new LinkedList<String>();
			DocumentationBlock docs = this.getDocumentation();

			if (docs != null && docs.hasTags())
			{
				for (Tag tag : docs.getTags())
				{
					if (tag.getType() == TagType.RETURN)
					{
						TagWithTypes tagWithTypes = (TagWithTypes) tag;

						for (Type type : tagWithTypes.getTypes())
						{
							fReturnTypes.add(type.getName());
						}
					}
				}
			}
		}

		return fReturnTypes;
	}

	/*
	 * (non-Javadoc)
	 * @see com.aptana.parsing.ast.ParseBaseNode#getText()
	 */
	@Override
	public String getText()
	{
		return this.getName().getText();
	}
}
