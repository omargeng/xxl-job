package com.xxl.job.core.executor.impl;

import com.xxl.job.core.executor.XxlJobExecutor;
import com.xxl.job.core.glue.GlueFactory;
import com.xxl.job.core.handler.IJobHandler;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import java.util.Map;

/**
 * @Author omar
 * Company:   csii
 * @version: 1.0
 * @since: JDK 1.6.0_26
 * Create at:   2018/11/28
 * Description:
 */
public class XxlJobSpringExecutor4PE extends XxlJobExecutor implements ApplicationContextAware {
    private static ApplicationContext applicationContext;

    @Override
    public void start() throws Exception {

        // init JobHandler Repository
        initJobHandlerRepository();

        // refresh GlueFactory
        GlueFactory.refreshInstance(1);


        // super start
        super.start();
    }

    private void initJobHandlerRepository(){
        // init job handler action
        Map<String, IJobHandler> serviceBeanMap = applicationContext.getBeansOfType(IJobHandler.class);

        if (serviceBeanMap!=null && serviceBeanMap.size()>0) {
            for(Map.Entry<String,IJobHandler> entry:serviceBeanMap.entrySet()){
                IJobHandler handler = entry.getValue();
                String name=entry.getKey();
                if (loadJobHandler(name) != null) {
                    throw new RuntimeException("xxl-job jobhandler naming conflicts.");
                }
                registJobHandler(name, handler);
            }
        }
    }

    @Override
    public void destroy() {

        super.destroy();
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext=applicationContext;
    }
}
