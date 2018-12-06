package com.xxl.job.core.log;

import org.apache.commons.logging.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.helpers.FormattingTuple;
import org.slf4j.helpers.MessageFormatter;

import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * @Author omar
 * Company:   csii
 * @version: 1.0
 * @since: JDK 1.6.0_26
 * Create at:   2018/11/28
 * Description:
 */
public class XxlJobLogger4PE extends XxlJobLogger{

    private static Logger logger = LoggerFactory.getLogger("xxl-job logger");



    /**
     * append log with pattern
     *
     * @param appendLogPattern  like "aaa {} bbb {} ccc"
     * @param appendLogArguments    like "111, true"
     */
    public static void log(String appendLogPattern, Object ... appendLogArguments) {

        FormattingTuple ft = MessageFormatter.arrayFormat(appendLogPattern, appendLogArguments);
        String appendLog = ft.getMessage();

        /*appendLog = appendLogPattern;
        if (appendLogArguments!=null && appendLogArguments.length>0) {
            appendLog = MessageFormat.format(appendLogPattern, appendLogArguments);
        }*/

        StackTraceElement callInfo = new Throwable().getStackTrace()[1];
        logDetail(callInfo, appendLog);
    }

    public static void log(String appendLogPattern, Log log, Object ... appendLogArguments) {
        FormattingTuple ft = MessageFormatter.arrayFormat(appendLogPattern, appendLogArguments);
        String appendLog = ft.getMessage();
        if(log!=null){
            log.info(appendLog);
        }
        StackTraceElement callInfo = new Throwable().getStackTrace()[1];
        logDetail(callInfo, appendLog);
    }



    /**
     * append exception stack
     *
     * @param e
     */
    public static void log(Throwable e) {

        StringWriter stringWriter = new StringWriter();
        e.printStackTrace(new PrintWriter(stringWriter));
        String appendLog = stringWriter.toString();

        StackTraceElement callInfo = new Throwable().getStackTrace()[1];
        logDetail(callInfo, appendLog);
    }
}
