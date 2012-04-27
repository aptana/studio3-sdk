/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.editor.js.sdoc.model;

public class PrivateTag extends Tag
{
	/**
	 * PrivateTag
	 * 
	 * @param text
	 */
	public PrivateTag(String text)
	{
		super(TagType.PRIVATE, text);
	}
}
