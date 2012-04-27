/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.parsing;

import java.util.List;
import java.util.Map;

import com.aptana.parsing.ast.IParseError;
import com.aptana.parsing.ast.IParseRootNode;
import com.aptana.parsing.lexer.IRange;

public interface IParseState
{
	/**
	 * This will clean up the source passed in via {@link #setEditState(String, int)} for RAM/GC purposes. The
	 * implementation should retain a hashcode of the source or any other artifacts to be able to compare later via
	 * {@link #requiresReparse(IParseState)}
	 */
	public void clearEditState();

	/**
	 * getParseResult
	 * 
	 * @return
	 */
	public IParseRootNode getParseResult();

	/**
	 * getSource
	 * 
	 * @return
	 */
	public String getSource();

	/**
	 * getStartingOffset
	 * 
	 * @return
	 */
	public int getStartingOffset();

	/**
	 * Returns the list of ranges in the source to skip.
	 * 
	 * @return the list of ranges in an array
	 */
	public IRange[] getSkippedRanges();

	/**
	 * Returns language-specific properties related to the parser.
	 * 
	 * @return the properties in a map
	 */
	public Map<String, Object> getProperties();

	/**
	 * Equal to calling {@link #setEditState(String, int)} with starting offset of 0.
	 * 
	 * @param source
	 * @param startingOffset
	 */
	public void setEditState(String source);

	/**
	 * Sets the source to operate on along with the starting offset to use. Typically this would be 0, if that is the
	 * case, use {@link #setEditState(String)}
	 * 
	 * @param source
	 * @param startingOffset
	 *            Typically 0, use a non-zero value for parsing embedded languages that don't start at the beginning of
	 *            the file.
	 */
	public void setEditState(String source, int startingOffset);

	/**
	 * setParseResult
	 * 
	 * @param result
	 */
	public void setParseResult(IParseRootNode result);

	/**
	 * Returns a list of the errors found in the document.
	 * 
	 * @return an list of IParseError
	 */
	public List<IParseError> getErrors();

	/**
	 * Adds error to the list of errors
	 * 
	 * @param error
	 */
	public void addError(IParseError error);

	/**
	 * Clears the list of errors
	 */
	public void clearErrors();

	/**
	 * Remove the specified error from the list of errors
	 * 
	 * @param error
	 */
	public void removeError(IParseError error);

	/**
	 * Given the new parse state, does this old one encompass the requirements? (i.e. can we just re-use the parse
	 * result from this parse state instead of doing a re-parse?)
	 * 
	 * @param newState
	 * @return
	 */
	public boolean requiresReparse(IParseState newState);

}
