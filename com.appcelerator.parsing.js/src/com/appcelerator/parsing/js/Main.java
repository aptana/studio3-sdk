/**
 * Aptana Studio
 * Copyright (c) 2005-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.appcelerator.parsing.js;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.text.MessageFormat;
import java.util.List;

import com.aptana.editor.js.parsing.JSParseState;
import com.aptana.editor.js.parsing.JSParser;
import com.aptana.parsing.IParseState;
import com.aptana.parsing.ast.IParseError;
import com.aptana.parsing.ast.IParseRootNode;
import com.aptana.parsing.ast.ParseNode;
import com.aptana.parsing.util.ParseUtil;

/**
 * Main
 */
public class Main
{
	/**
	 * Based on
	 * http://stackoverflow.com/questions/309424/in-java-how-do-a-read-convert-an-inputstream-in-to-a-string/309718
	 * #309718
	 * 
	 * @param is
	 * @return a UTF-8 string of the input stream
	 */
	public static String getString(InputStream is)
	{
		char[] buffer = new char[0x10000];
		StringBuilder out = new StringBuilder();

		try
		{
			Reader in = new InputStreamReader(is, "UTF-8");
			int read;

			do
			{
				read = in.read(buffer, 0, buffer.length);

				if (read > 0)
				{
					out.append(buffer, 0, read);
				}
			}
			while (read >= 0);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				is.close();
			}
			catch (IOException e)
			{
			}
		}

		return out.toString();
	}

	/**
	 * Pass in one or more files as arguments. There are some sample files being collected in the top-level "samples"
	 * directory in this project.
	 * 
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args)
	{
		if (args != null && args.length > 0)
		{
			Main processor = new Main();

			for (String filename : args)
			{
				processor.process(filename);
			}
		}
		else
		{
			System.out.println("usage: jsparser <js-file>+");
		}
	}

	/**
	 * @param filename
	 * @return
	 * @throws FileNotFoundException
	 */
	private String getSource(String filename) throws FileNotFoundException
	{
		FileInputStream fis = new FileInputStream(filename);
		String source = getString(fis);

		System.out.println();
		System.out.println("Source");
		System.out.println("======");
		System.out.print(source);

		return source;
	}

	/**
	 * Process a JS file and print some results of that
	 * 
	 * @param filename
	 */
	public void process(String filename)
	{
		System.out.println("Processing " + filename);

		try
		{
			JSParser parser = new JSParser();
			JSParseState parseState = new JSParseState();
			String source = getSource(filename);

			parseState.setCollectComments(false); // do not collect comments nor attach to root of AST
			parseState.setAttachComments(false); // do not parse doc comments nor attach models to AST nodes
			parseState.setEditState(source);
			IParseRootNode result = parser.parse(parseState);

			if (result != null)
			{
				showErrorsAndWarnings(parseState);
				showToStringResult(result);
				showToXMLResult(result);
				showToTreeStringResult(result);
			}
			else
			{
				System.err.println();
				System.err.println("Hmm, an AST was not created.");
			}
		}
		catch (Exception e)
		{
			System.err.println("The following error occurred while processing '" + filename + "'");
			e.printStackTrace();
		}
	}

	/**
	 * Display any errors and/or warning that were encountered during the parse
	 * 
	 * @param parseState
	 */
	private void showErrorsAndWarnings(IParseState parseState)
	{
		List<IParseError> errorsAndWarnings = parseState.getErrors();

		if (errorsAndWarnings != null && !errorsAndWarnings.isEmpty())
		{
			System.out.println();
			System.out.println("Errors and Warnings");
			System.out.println("===================");

			for (IParseError error : errorsAndWarnings)
			{
				// @formatter:off
				String message = MessageFormat.format(
					"{0} at offset {1}: {2}",
					error.getSeverity(),
					error.getOffset(),
					error.getMessage()
				);
				// @formatter:on

				System.out.println(message);
			}
		}
	}

	/**
	 * Show the results of calling toString on the AST
	 * 
	 * @param result
	 */
	private void showToStringResult(IParseRootNode result)
	{
		System.out.println();
		System.out.println("Result (toString)");
		System.out.println("=================");
		System.out.println(result);
	}

	/**
	 * Show the results of converting the AST to a Lisp-like syntax
	 * 
	 * @param result
	 */
	private void showToTreeStringResult(IParseRootNode result)
	{
		System.out.println();
		System.out.println("Result (toTreeString)");
		System.out.println("=====================");
		System.out.println(ParseUtil.toTreeString(result));
	}

	/**
	 * Show the results of calling toXML on the AST
	 * 
	 * @param result
	 */
	private void showToXMLResult(IParseRootNode result)
	{
		if (result instanceof ParseNode)
		{
			System.out.println();
			System.out.println("Result (toXML)");
			System.out.println("==============");
			System.out.println(((ParseNode) result).toXML());
		}
	}
}
