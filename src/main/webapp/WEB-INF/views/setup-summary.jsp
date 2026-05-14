<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로젝트 셋업 정리 - AppProject01</title>
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
    body {
        font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        min-height: 100vh;
        padding: 40px 20px;
        color: #333;
    }
    
    .container {
        max-width: 1000px;
        margin: 0 auto;
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        overflow: hidden;
    }
    
    .header {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        color: #fff;
        padding: 40px;
        text-align: center;
    }
    
    .header h1 {
        font-size: 32px;
        margin-bottom: 10px;
        font-weight: 700;
    }
    
    .header p {
        font-size: 16px;
        opacity: 0.9;
    }
    
    .header .badge {
        display: inline-block;
        background: rgba(255,255,255,0.2);
        padding: 6px 16px;
        border-radius: 20px;
        margin-top: 15px;
        font-size: 13px;
    }
    
    .content {
        padding: 40px;
    }
    
    .section {
        margin-bottom: 35px;
    }
    
    .section-title {
        font-size: 20px;
        color: #1e3c72;
        margin-bottom: 18px;
        padding-bottom: 10px;
        border-bottom: 3px solid #2a5298;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .section-title .num {
        background: #2a5298;
        color: white;
        width: 30px;
        height: 30px;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        font-weight: bold;
    }
    
    .step-card {
        background: #f8faff;
        border-left: 4px solid #2a5298;
        padding: 18px 22px;
        margin-bottom: 12px;
        border-radius: 6px;
        transition: transform 0.2s;
    }
    
    .step-card:hover {
        transform: translateX(5px);
    }
    
    .step-card .label {
        display: inline-block;
        background: #2a5298;
        color: white;
        padding: 3px 10px;
        border-radius: 4px;
        font-size: 12px;
        margin-bottom: 8px;
        font-weight: bold;
    }
    
    .step-card .label.success { background: #28a745; }
    .step-card .label.warning { background: #ff9800; }
    .step-card .label.error { background: #dc3545; }
    
    .step-card h3 {
        color: #1e3c72;
        margin-bottom: 8px;
        font-size: 16px;
    }
    
    .step-card p {
        color: #555;
        line-height: 1.6;
        font-size: 14px;
    }
    
    .step-card code {
        background: #fff;
        border: 1px solid #ddd;
        padding: 2px 8px;
        border-radius: 4px;
        font-family: 'Consolas', 'Monaco', monospace;
        font-size: 13px;
        color: #d63384;
    }
    
    .code-block {
        background: #2d3748;
        color: #e2e8f0;
        padding: 16px 20px;
        border-radius: 8px;
        font-family: 'Consolas', 'Monaco', monospace;
        font-size: 13px;
        margin: 10px 0;
        overflow-x: auto;
        line-height: 1.6;
    }
    
    .code-block .comment { color: #68d391; }
    .code-block .keyword { color: #f6ad55; }
    .code-block .string { color: #fbb6ce; }
    
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 15px;
        margin-top: 15px;
    }
    
    .info-card {
        background: #fff;
        border: 1px solid #e0e7ff;
        padding: 16px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    
    .info-card .key {
        font-size: 12px;
        color: #888;
        text-transform: uppercase;
        font-weight: bold;
        margin-bottom: 5px;
    }
    
    .info-card .value {
        font-size: 15px;
        color: #1e3c72;
        font-weight: 600;
        word-break: break-all;
    }
    
    .summary-box {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        padding: 25px;
        border-radius: 12px;
        text-align: center;
        margin-top: 20px;
    }
    
    .summary-box h2 {
        font-size: 22px;
        margin-bottom: 10px;
    }
    
    .footer {
        background: #f8faff;
        padding: 20px 40px;
        text-align: center;
        color: #888;
        font-size: 13px;
        border-top: 1px solid #e0e7ff;
    }
    
    .nav-links {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-top: 20px;
        flex-wrap: wrap;
    }
    
    .nav-links a {
        padding: 10px 20px;
        background: #2a5298;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-size: 14px;
        transition: background 0.2s;
    }
    
    .nav-links a:hover {
        background: #1e3c72;
    }
    
    .warning-box {
        background: #fff3cd;
        border-left: 4px solid #ff9800;
        padding: 15px 20px;
        border-radius: 6px;
        margin-top: 15px;
        color: #856404;
    }
    
    .warning-box strong {
        color: #b45309;
    }
</style>
</head>
<body>

<div class="container">
    
    <!-- 헤더 -->
    <div class="header">
        <h1>🚀 AppProject01 셋업 정리</h1>
        <p>eGovFramework 5.0 + Spring 6.2 + Vue.js 프로젝트 환경 구축 기록</p>
        <span class="badge">📅 2026.04.28 작업</span>
    </div>
    
    <div class="content">
        
        <!-- 환경 정보 -->
        <div class="section">
            <div class="section-title">
                <span class="num">📋</span> 프로젝트 환경
            </div>
            <div class="info-grid">
                <div class="info-card">
                    <div class="key">Framework</div>
                    <div class="value">eGovFramework 5.0</div>
                </div>
                <div class="info-card">
                    <div class="key">Spring</div>
                    <div class="value">6.2.0</div>
                </div>
                <div class="info-card">
                    <div class="key">Spring Security</div>
                    <div class="value">6.3.4</div>
                </div>
                <div class="info-card">
                    <div class="key">Java</div>
                    <div class="value">JDK 21 (LTS)</div>
                </div>
                <div class="info-card">
                    <div class="key">Tomcat</div>
                    <div class="value">10.1.36 (Jakarta EE)</div>
                </div>
                <div class="info-card">
                    <div class="key">Database</div>
                    <div class="value">AWS RDS MySQL</div>
                </div>
            </div>
        </div>
        
        <!-- 작업 단계 -->
        <div class="section">
            <div class="section-title">
                <span class="num">1</span> Maven 프로젝트 변환
            </div>
            <div class="step-card">
                <span class="label success">완료</span>
                <h3>일반 웹 프로젝트 → Maven 프로젝트로 전환</h3>
                <p>프로젝트가 Maven 구조로 인식되지 않아 <code>Maven Dependencies</code>가 안 보이던 상태였음. 
                <code>Convert to Maven Project</code>로 변환하여 의존성 자동 관리 활성화.</p>
            </div>
        </div>
        
        <div class="section">
            <div class="section-title">
                <span class="num">2</span> Spring 버전 충돌 해결
            </div>
            <div class="step-card">
                <span class="label error">에러</span>
                <h3>NoClassDefFoundError: BeanFactoryInitializer</h3>
                <p><strong>원인:</strong> eGovFramework 5.0의 Spring 6.2와 사용자가 명시한 Spring Security 6.1.5가 충돌. 
                spring-beans는 옛 버전, spring-context는 새 버전이라 클래스를 못 찾음.</p>
            </div>
            <div class="step-card">
                <span class="label success">해결</span>
                <h3>BOM(Bill of Materials)으로 버전 통일</h3>
                <p><code>pom.xml</code>에 <code>spring-framework-bom</code>과 <code>spring-security-bom</code>을 import하여 
                모든 Spring 모듈이 동일한 버전을 사용하도록 강제.</p>
                <div class="code-block">
<span class="comment">&lt;!-- pom.xml --&gt;</span>
<span class="keyword">&lt;properties&gt;</span>
    &lt;spring.version&gt;<span class="string">6.2.0</span>&lt;/spring.version&gt;
    &lt;spring.security.version&gt;<span class="string">6.3.4</span>&lt;/spring.security.version&gt;
<span class="keyword">&lt;/properties&gt;</span>
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-title">
                <span class="num">3</span> Interceptor 클래스 누락 처리
            </div>
            <div class="step-card">
                <span class="label error">에러</span>
                <h3>ClassNotFoundException: MonitoringInterceptor</h3>
                <p><strong>원인:</strong> <code>servlet-context.xml</code>에서 등록한 인터셉터 클래스가 실제로 존재하지 않음.</p>
            </div>
            <div class="step-card">
                <span class="label success">해결</span>
                <h3>인터셉터 등록 부분 주석 처리</h3>
                <p>일단 화면을 띄우는 게 우선이라 <code>&lt;interceptors&gt;</code> 블록 전체를 주석 처리. 
                나중에 인터셉터 클래스를 만든 뒤 주석 해제 예정.</p>
            </div>
        </div>
        
        <div class="section">
            <div class="section-title">
                <span class="num">4</span> JDBC 드라이버 변경
            </div>
            <div class="step-card">
                <span class="label error">에러</span>
                <h3>ClassNotFoundException: net.sf.log4jdbc.DriverSpy</h3>
                <p><strong>원인:</strong> log4jdbc 라이브러리의 드라이버 클래스를 못 찾음 (버전별로 패키지 경로가 다름).</p>
            </div>
            <div class="step-card">
                <span class="label success">해결</span>
                <h3>log4jdbc 제거하고 MySQL 직접 연결</h3>
                <p>SQL 로그가 꼭 필요한 게 아니므로 일단 표준 MySQL 드라이버로 변경.</p>
                <div class="code-block">
<span class="comment">&lt;!-- 변경 전 --&gt;</span>
driverClassName=<span class="string">"net.sf.log4jdbc.DriverSpy"</span>
url=<span class="string">"jdbc:log4jdbc:mysql://..."</span>

<span class="comment">&lt;!-- 변경 후 --&gt;</span>
driverClassName=<span class="string">"com.mysql.cj.jdbc.Driver"</span>
url=<span class="string">"jdbc:mysql://..."</span>
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-title">
                <span class="num">5</span> Component Scan 패턴 수정
            </div>
            <div class="step-card">
                <span class="label warning">주의</span>
                <h3>HomeController가 Spring에 등록 안 됨</h3>
                <p><strong>원인:</strong> <code>base-package="com.springmvc.*"</code>의 와일드카드(<code>.*</code>)가 
                Spring에서 의도와 다르게 동작하여 컨트롤러를 못 찾음.</p>
            </div>
            <div class="step-card">
                <span class="label success">해결</span>
                <h3>와일드카드 제거</h3>
                <p><code>com.springmvc</code>만 적어도 모든 하위 패키지가 자동으로 스캔됨.</p>
                <div class="code-block">
<span class="comment">&lt;!-- ❌ 잘못된 예 --&gt;</span>
&lt;context:component-scan base-package=<span class="string">"com.springmvc.*"</span>/&gt;

<span class="comment">&lt;!-- ✅ 올바른 예 --&gt;</span>
&lt;context:component-scan base-package=<span class="string">"com.springmvc"</span>/&gt;
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-title">
                <span class="num">6</span> HomeController 생성
            </div>
            <div class="step-card">
                <span class="label success">완료</span>
                <h3>메인 페이지 라우팅 컨트롤러</h3>
                <p>루트 URL(<code>/</code>) 접속 시 <code>index.jsp</code>를, <code>/login</code> 접속 시 
                <code>login.jsp</code>를 띄우도록 매핑.</p>
                <div class="code-block">
<span class="keyword">@Controller</span>
<span class="keyword">public class</span> HomeController {
    <span class="keyword">@RequestMapping</span>(<span class="string">"/"</span>)
    <span class="keyword">public</span> String home() {
        <span class="keyword">return</span> <span class="string">"index"</span>;  <span class="comment">// → /WEB-INF/views/index.jsp</span>
    }
    
    <span class="keyword">@RequestMapping</span>(<span class="string">"/login"</span>)
    <span class="keyword">public</span> String login() {
        <span class="keyword">return</span> <span class="string">"login"</span>;  <span class="comment">// → /WEB-INF/views/login.jsp</span>
    }
}
                </div>
            </div>
        </div>
        
        <!-- 보안 경고 -->
        <div class="warning-box">
            <strong>⚠️ 보안 주의사항:</strong> 
            현재 <code>servlet-context.xml</code>에 AWS RDS 비밀번호가 하드코딩되어 있습니다. 
            운영 환경에서는 반드시 <code>application.properties</code> 같은 외부 파일로 분리하고, 
            <code>.gitignore</code>에 추가하여 Git에 올라가지 않도록 해야 합니다.
        </div>
        
        <!-- 최종 요약 -->
        <div class="summary-box">
            <h2>✅ 환경 구축 완료!</h2>
            <p>모든 에러가 해결되어 메인 페이지가 정상적으로 렌더링됩니다.</p>
        </div>
        
        <!-- 페이지 이동 -->
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/">🏠 메인 페이지</a>
            <a href="<%= request.getContextPath() %>/login">🔐 로그인 페이지</a>
        </div>
        
    </div>
    
    <div class="footer">
        AppProject01 · eGovFramework 5.0 · 작성일: <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date()) %>
    </div>
    
</div>

</body>
</html>
