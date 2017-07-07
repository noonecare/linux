package com.wangmeng.ci.jenkins;

import static org.junit.Assert.*;

/**
 * Created by T440P on 2017/7/7.
 */
public class MavenDemoTest {
    @org.junit.Test
    public void operate() throws Exception {
        int a = 3;
        int b = 4;
        int expected = 7;
        System.out.println("MavenDemoTest is running");
        MavenDemo mavenDemo = new MavenDemo();
        assert(mavenDemo.operate(a, b) == expected);
    }

}