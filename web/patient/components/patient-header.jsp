<div class="patient-page-header">

    <div class="patient-page-header-content">

        <!-- Breadcrumb -->
        <nav class="patient-breadcrumb"
             aria-label="Breadcrumb">

            <a href="${pageContext.request.contextPath}/patient/dashboard.jsp">
                Home
            </a>

            <span class="patient-breadcrumb-separator">
                /
            </span>

            <span class="patient-breadcrumb-current">
                ${pageTitle}
            </span>

        </nav>


        <!-- Page Title -->
        <div class="patient-page-title-wrapper">

            <h1 class="patient-page-title">
                ${pageTitle}
            </h1>

            <p class="patient-page-description">
                ${pageDescription}
            </p>

        </div>

    </div>

</div>