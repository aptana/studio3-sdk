/**
 * Aptana Studio
 * Copyright (c) 2005-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the GNU Public License (GPL) v3 (with exceptions).
 * Please see the license.html included with this distribution for details.
 * Any modifications to this file must keep this entire header intact.
 */
package com.aptana.core.util;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Pattern;

public class StringUtil
{
	/**
	 * EMPTY
	 */
	public static final String EMPTY = ""; //$NON-NLS-1$

	/**
	 * regexp for counting lines and splitting strings by lines.
	 */
	public static final Pattern LINE_SPLITTER = Pattern.compile("\r?\n|\r"); //$NON-NLS-1$

	private static final Pattern HTML_TAG_PATTERN = Pattern.compile("\\<.*?\\>"); //$NON-NLS-1$

	/**
	 * characterInstanceCount
	 * 
	 * @param source
	 * @param c
	 * @return
	 */
	public static int characterInstanceCount(String source, char c)
	{
		int result = -1;

		if (source != null)
		{
			int length = source.length();

			result = 0;

			for (int i = 0; i < length; i++)
			{
				if (source.charAt(i) == c)
				{
					result++;
				}
			}
		}

		return result;
	}

	/**
	 * Compares two strings for ordering taking into account that none, one, or both may be null. We respect case
	 * differences here
	 * 
	 * @param s1
	 * @param s2
	 * @return
	 */
	public static int compare(String s1, String s2)
	{
		s1 = getStringValue(s1);
		s2 = getStringValue(s2);

		return s1.compareTo(s2);
	}

	/**
	 * Compares two strings for ordering taking into account that none, one, or both may be null. We ignore case
	 * differences here
	 * 
	 * @param s1
	 * @param s2
	 * @return
	 */
	public static int compareCaseInsensitive(String s1, String s2)
	{
		s1 = getStringValue(s1);
		s2 = getStringValue(s2);

		return s1.compareToIgnoreCase(s2);
	}

	/**
	 * Concatenate a collection of strings
	 * 
	 * @param items
	 *            The collection of strings to concatenate
	 * @return
	 */
	public static String concat(Collection<String> items)
	{
		return (items != null) ? join(null, items.toArray(new String[items.size()])) : null;
	}

	/**
	 * Concatenate a list of strings.
	 * 
	 * @param items
	 *            The list of strings to concatenate
	 * @return
	 */
	public static String concat(String... items)
	{
		return join(null, items);
	}

	/**
	 * Determine if a specified string exists in an array of strings
	 * 
	 * @param set
	 *            The array of strings to test against
	 * @param toFind
	 *            The string to search for in the array of strings
	 * @return
	 */
	public static boolean contains(String[] set, String toFind)
	{
		if (set != null && toFind != null)
		{
			for (String value : set)
			{
				if (value.equals(toFind))
				{
					return true;
				}
			}
		}

		return false;
	}

	/**
	 * Adds an ellipsis to the end of a string, generally indicating that this string leads to another choice (like a
	 * dialog)
	 * 
	 * @param message
	 * @return The ellipsif-ied string
	 */
	public static String ellipsify(String message)
	{
		return message == null ? null : message + "..."; //$NON-NLS-1$
	}

	/**
	 * Walk forwards through the string to find the next whitespace character. If the current char is a whitespace char,
	 * return the current offset
	 * 
	 * @param document
	 * @param offset
	 * @return
	 */
	public static int findNextWhitespaceOffset(String string, int offset)
	{
		int i = -1;

		if (string == null || EMPTY.equals(string) || offset > string.length())
			return i;

		int j = offset;
		while (j < string.length())
		{
			char ch = string.charAt(j);
			if (Character.isWhitespace(ch))
			{
				i = j;
				break;
			}
			j++;
		}
		return i;
	}

	/**
	 * Walk backwards through the string to find the previous whitespace character.
	 * 
	 * @param document
	 * @param offset
	 * @return
	 */
	public static int findPreviousWhitespaceOffset(String string, int offset)
	{
		int i = -1;

		if (string == null || EMPTY.equals(string) || offset > string.length())
			return i;

		int j = offset;
		while (j > 0)
		{
			char ch = string.charAt(j - 1);
			if (Character.isWhitespace(ch))
			{
				i = j - 1;
				break;
			}
			j--;
		}
		return i;
	}

	/**
	 * Formats the string with replacement values
	 * 
	 * @param str
	 * @param replacement
	 * @return String
	 */
	public static String format(String str, int replacement)
	{
		return MessageFormat.format(str, new Object[] { Integer.toString(replacement) });
	}

	/**
	 * Formats the string with replacement values
	 * 
	 * @param str
	 * @param replacement
	 * @return String
	 */
	public static String format(String str, long replacement)
	{
		return MessageFormat.format(str, new Object[] { Long.toString(replacement) });
	}

	/**
	 * Formats the string with replacement values
	 * 
	 * @param str
	 * @param replacement
	 * @return String
	 */
	public static String format(String str, Object replacement)
	{
		return MessageFormat.format(str, new Object[] { replacement.toString() });
	}

	/**
	 * Formats the string with replacement values
	 * 
	 * @param str
	 * @param replacements
	 * @return String
	 */
	public static String format(String str, Object[] replacements)
	{
		return MessageFormat.format(str, replacements);
	}

	/**
	 * Formats the string with replacement values
	 * 
	 * @param str
	 * @param replacement
	 * @return String
	 */
	public static String format(String str, String replacement)
	{
		return MessageFormat.format(str, new Object[] { replacement });
	}

	/**
	 * getStringValue
	 * 
	 * @param object
	 * @return
	 */
	public static String getStringValue(Object object)
	{
		return (object != null) ? object.toString() : EMPTY;
	}

	public static boolean isEmpty(String text)
	{
		return text == null || text.trim().length() == 0;
	}

	/**
	 * Create a string by concatenating the elements of a collection using a delimiter between each item
	 * 
	 * @param delimiter
	 *            The text to place between each element in the array
	 * @param items
	 *            The collection of items to join
	 * @return The resulting string
	 */
	public static String join(String delimiter, Collection<String> items)
	{
		return (items != null) ? join(delimiter, items.toArray(new String[items.size()])) : null;
	}

	/**
	 * Create a string by concatenating the elements of a string array using a delimiter between each item
	 * 
	 * @param delimiter
	 *            The text to place between each element in the array
	 * @param items
	 *            The array of items to join
	 * @return The resulting string
	 */
	public static String join(String delimiter, String... items)
	{
		String result = null;

		if (items != null)
		{
			switch (items.length)
			{
				case 0:
				{
					result = EMPTY;
					break;
				}

				case 1:
				{
					result = items[0];
					break;
				}

				// NOTE: consider adding additional cases here, probably for at least 2, by unrolling the loop from the
				// default section below

				default:
				{
					int lastIndex = items.length - 1;

					// determine length of the delimiter
					int delimiterLength = (delimiter != null) ? delimiter.length() : 0;

					// determine the length of the resulting string, starting with the length of all delimiters
					int targetLength = (lastIndex) * delimiterLength;

					// now add in the length of each item in our list of items
					for (int i = 0; i <= lastIndex; i++)
					{
						targetLength += items[i].length();
					}

					// build the resulting character array
					int offset = 0;
					char[] accumulator = new char[targetLength];

					// NOTE: We test for delimiter length here to avoid having a conditional within the for-loops in the
					// true/false blocks. Moving the conditional inside the for-loop barely improved the performance of
					// this implementation from the StringBuilder version we had before
					if (delimiterLength != 0)
					{
						// copy all items (except last) and all delimiters
						for (int i = 0; i < lastIndex; i++)
						{
							String item = items[i];

							// cache current item's length
							int length = item.length();

							// copy the item into the accumulator
							item.getChars(0, length, accumulator, offset);
							offset += length;

							// copy in the delimiter
							delimiter.getChars(0, delimiterLength, accumulator, offset);
							offset += delimiterLength;
						}

						String item = items[lastIndex];
						item.getChars(0, item.length(), accumulator, offset);
					}
					else
					{
						// NOTE: use classic iteration to avoid the overhead of an iterator
						for (int i = 0; i <= lastIndex; i++)
						{
							String item = items[i];

							// cache current item's length
							int length = item.length();

							// copy the item into the accumulator
							item.getChars(0, length, accumulator, offset);
							offset += length;
						}
					}

					// convert the result to a String and return that value
					result = new String(accumulator);
				}
			}
		}

		return result;
	}

	/**
	 * Adds a colon to the end of the string, as if making a form label
	 * 
	 * @param message
	 * @return string + colon
	 */
	public static String makeFormLabel(String message)
	{
		return message == null ? null : message + ":"; //$NON-NLS-1$
	}

	/**
	 * @param string
	 * @param desiredLength
	 * @param padChar
	 * @return
	 */
	public static String pad(String string, int desiredLength, char padChar)
	{
		if (string == null)
		{
			string = EMPTY;
		}

		while (string.length() < desiredLength)
		{
			string = padChar + string;
		}
		return string;
	}

	/**
	 * Add single quotes around the given string.
	 * 
	 * @param string
	 * @return
	 */
	public static String quote(String string)
	{
		return string == null ? null : '\'' + string + '\'';
	}

	/**
	 * Replace one string with another
	 * 
	 * @param str
	 * @param pattern
	 * @param replace
	 * @return String
	 */
	public static String replace(String str, String pattern, String replace)
	{
		if (str == null)
		{
			return null;
		}

		int s = 0;
		int e = 0;
		StringBuilder result = new StringBuilder();
		while ((e = str.indexOf(pattern, s)) >= 0)
		{
			result.append(str.substring(s, e));
			result.append(replace);
			s = e + pattern.length();
		}
		result.append(str.substring(s));

		return result.toString();
	}

	/**
	 * Given a raw input string template, this will do a mass search and replace for the map of variables to values.
	 * Acts like {@link String#replaceAll(String, String)}
	 * 
	 * @param template
	 * @param variables
	 * @return
	 */
	public static String replaceAll(String template, Map<String, String> variables)
	{
		if (template == null || variables == null || variables.isEmpty())
		{
			return template;
		}
		for (Map.Entry<String, String> entry : variables.entrySet())
		{
			String value = entry.getValue();
			if (value == null)
			{
				value = EMPTY;
			}
			else
			{
				value = value.replace('$', (char) 1); // To avoid illegal group reference issues if the text has
														// dollars!
			}
			template = template.replaceAll(entry.getKey(), value).replace((char) 1, '$');
		}
		return template;
	}

	/**
	 * Does the string start with the specific char
	 * 
	 * @param string
	 *            the string to test
	 * @param c
	 *            the char to test
	 * @return true if yes, false if the no, or the string is empty or null
	 */
	public static boolean startsWith(String string, char c)
	{
		return !StringUtil.isEmpty(string) && string.charAt(0) == c;
	}

	public static boolean startsWith(String string, String prefix)
	{
		return !StringUtil.isEmpty(string) && string.startsWith(prefix);
	}

	/**
	 * Removes <.*?> inside a string. If the specified value is empty or null, then it is returned untouched
	 * 
	 * @param textWithHTML
	 * @return
	 */
	public static String stripHTMLTags(String textWithHTML)
	{
		// @formatter:off
		return (!StringUtil.isEmpty(textWithHTML))
			?	HTML_TAG_PATTERN.matcher(textWithHTML).replaceAll(EMPTY)
			:	textWithHTML;
		// @formatter:on
	}

	/**
	 * Runs the input through a StringTokenizer and gathers up all the tokens.
	 * 
	 * @param inputString
	 * @param delim
	 * @return
	 */
	public static List<String> tokenize(String inputString, String delim)
	{
		List<String> tokens = new ArrayList<String>();
		if (inputString == null)
			return tokens;
		StringTokenizer tokenizer = new StringTokenizer(inputString, delim);
		while (tokenizer.hasMoreTokens())
			tokens.add(tokenizer.nextToken());
		return tokens;
	}

	/**
	 * Truncates the string to a particular length if it's longer and appends ... in the end.
	 * 
	 * @param text
	 *            the string to be truncated
	 * @param length
	 *            the length to truncate to
	 * @return the truncated string
	 */
	public static String truncate(String text, int length)
	{
		if (text == null || text.length() <= length)
		{
			return text;
		}
		return new String(ellipsify(text.substring(0, length)));
	}

	private StringUtil()
	{
	}
}
