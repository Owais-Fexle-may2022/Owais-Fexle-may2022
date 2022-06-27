public with sharing class LearningString {

    public LearningString() {
        // If maxWidth is less than four, this method throws a run-time exception.
        String s = 'Hello Maximillian';
        String s2 = s.abbreviate(8);
        System.assertEquals('Hello...', s2);
        System.assertEquals(8, s2.length());
        // returned String has ellipses appended at the start and the end 
        // if characters have been removed at these locations.
        String s1 = 'Hello Maximillian';
        // Start at M
        String s22 = s.abbreviate(9,6);
        System.assertEquals('...Max...', s22);
        System.assertEquals(9, s2.length());
        // Returns the current String with the first letter changed to title case.
        // String s3= 'hello maximillian';
        // String s3 = s3.capitalize();
        // System.assertEquals('Hello maximillian', s3);
        // Returns a version of the current String of the specified size padded with spaces on the left and righ
        // String s4 = 'hello';
        // String s4 = s4.center(9);
        // System.assertEquals('  hello  ',s4);
        // Returns a version of the current String of the specified size padded with the specified String on the left and right
        String s5 = 'hello';
        String s55 = s5.center(9, '-');
        System.assertEquals('--hello--', s55);
        // Returns the value of the character at the specified index.
        String str = 'Ω is Omega.';
        System.assertEquals(937, str.charAt(0));
        // difference between charAt and codePointAt codePointAt(0) returns the value for the entire surrogate pair.
        String str1 = '\uD835\uDD0A';
        System.assertEquals(55349, str1.charAt(0), 
            'charAt(0) didn\'t return the high surrogate.');
        System.assertEquals(120074, str1.codePointAt(0),
            'codePointAt(0) didn\'t return the entire two-character supplementary value.');
            // Returns the Unicode code point value that occurs before the specified index.
            String str2 = '\u03A9 is Ω (Omega), and \uD835\uDD0A ' + 
            ' is Fraktur Capital G.';
        System.assertEquals(937, str1.codePointBefore(1));
        System.assertEquals(120074, str1.codePointBefore(22));
        // Returns the number of Unicode code points within the specified text range.
        String str3 = '\u03A9 and \uD835\uDD0A characters.';
        System.debug('Count of code points for ' + str.substring(0,1) 
                    + ': ' + str.codePointCount(0,1));
        System.debug('Count of code points for ' + str.substring(6,8) 
                    + ': ' + str.codePointCount(6,8));
        // Output:
        // Count of code points for Ω: 1
        // Count of code points for 𝔊: 1
        // Compares two strings lexicographically, based on the Unicode value of each character in the Strings.
        String myString1 = 'abcde';
        String myString2 = 'abcd';
        Integer result = 
        myString1.compareTo(myString2);
        System.assertEquals(result, 1);
        // eturns true if and only if the String that called
        //  the method contains the specified sequence of characters in substring.
        // String myString1 = 'abcde';
        // String myString2 = 'abcd';
        Boolean result1 = 
        myString1.contains(myString2);
        System.assertEquals(result1, true);
        // Returns true if the current String contains any of the characters in the specified String; otherwise, returns false.
        String s6 = 'hello';
        Boolean b1 = s6.containsAny('hx');
        Boolean b2 = s6.containsAny('x');
        System.assertEquals(true, b1);
        System.assertEquals(false, b2);
        // Returns true if the current String contains the specified sequence of 
        // characters without regard to case; otherwise, returns false.
        String s66='hello';
        Boolean b =s66.containsIgnoreCase('HE');
        System.assertEquals(true,b);
        // Returns true if the current String doesn’t contain any of the characters in the specified String; otherwise, returns false.
        String s7 = 'abcde';
        System.assert(s7.containsNone('fg'));
        // eturns true if the current String contains characters only from the specified sequence of characters
        //  and not any other characters; otherwise, returns false.
        String s8 = 'abba';
        String s9 = 'abba xyz';
        Boolean b3 = s8.containsOnly('abcd');
        System.assertEquals(true,b1);
        Boolean b4 = s9.containsOnly('abcd');
        System.assertEquals(false,b2);
        // Returns true if the current String contains any white space characters
        String s10 = 'Hello Jane';
        System.assert(s10.containsWhitespace()); //true
        s10 = 'HelloJane ';
        System.assert(s10.containsWhitespace()); //true
        s10 = ' HelloJane';
        System.assert(s10.containsWhitespace()); //true
        s10 = 'HelloJane';
        System.assert(!s10.containsWhitespace()); //false
        // Returns the number of times the specified substring occurs
        String s11 = 'Hello Jane';
        System.assertEquals(1, s11.countMatches('Hello'));
        s11= 'Hello Hello';
        System.assertEquals(2, s11.countMatches('Hello'));
        s11 = 'Hello hello';
        System.assertEquals(1, s11.countMatches('Hello'));
        // If secondString is an empty string, this method returns an empty string
        String s12 = 'Hello Jane';
        String d1 = s12.difference('Hello Max');
        System.assertEquals('Max',d1);
        String d2 = s12.difference('Goodbye');
        System.assertEquals('Goodbye',d2);
        // Returns the index of the first occurrence of the specified substring. other wiese return -1
        String myString3 = 'abcde';
        String myString4 = 'cd';
        Integer result2 = myString3.indexOf(mystring4);
        System.assertEquals(2, result2);
        // Returns the zero-based index of the first occurrence of the specified substring from the point of the given index
        String myString5 = 'abcdabcd';
        String myString6 = 'ab';
        Integer result3 = myString5.indexOf(mystring6, 5);
        System.assertEquals(4, result3);
        // Returns the zero-based index of the first occurrence of a character that is not in the specified substring
        String s13 = 'abcd';
        String s14 = 'xc';
        Integer result4 = s13.indexOfAnyBut(s14);
        System.assertEquals(0, result4);
        // Returns the index of the first occurrence of the character that
        //  corresponds to the specified character value, starting from the specified index.
        String str4 = 'Ω and \\u03A9 and Ω';
        System.debug('indexOfChar(937)=' + str.indexOfChar(937));
        System.debug('indexOfChar(937,1)=' + str.indexOfChar(937,1));
        System.debug('indexOfChar(937,10)=' + str.indexOfChar(937,10));

        // Output:
        // indexOfChar(937)=0
        // indexOfChar(937,1)=6, (corresponds to the escaped form \\u03A9)
        // indexOfChar(937,10)=12
        // return all string in lower case 
        String allLower = 'abcde';
        System.assert(allLower.isAllLowerCase());
        // return all string in upper case 
        String allUpper = 'ABCDE';
        System.assert(allUpper.isAllUpperCase());
        // fopr alphanumericReturns true if all characters in the current String are Unicode letters or numbers only
        String alphanumSpace = 'AE 86';
        System.assert(alphanumSpace.isAlphanumericSpace());
        String notAlphanumSpace = 'aA$12';
        System.assert(!notAlphanumSpace.isAlphaSpace());
    }
            
}