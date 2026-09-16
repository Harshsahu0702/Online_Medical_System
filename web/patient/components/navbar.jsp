<header class="app-navbar">

    <!-- Left Side -->
    <div class="navbar-left">

        <!-- Mobile Menu Button -->
        <button
            type="button"
            class="mobile-menu-btn"
            id="mobileMenuToggle"
            aria-label="Toggle navigation menu"
            aria-expanded="false">

            <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                <line x1="4" x2="20" y1="12" y2="12"/>
                <line x1="4" x2="20" y1="6" y2="6"/>
                <line x1="4" x2="20" y1="18" y2="18"/>
            </svg>

        </button>


        <!-- Global Search -->
        <div class="global-search-bar">

            <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                <circle cx="11" cy="11" r="8"/>
                <path d="m21 21-4.3-4.3"/>
            </svg>

            <input
                type="search"
                id="globalSearchInput"
                class="global-search-input"
                placeholder="Search doctors, symptoms, medicines..."
                aria-label="Search doctors, symptoms, medicines"
                autocomplete="off">

        </div>

    </div>


    <!-- Right Side -->
    <div class="navbar-right">

        <!-- Emergency SOS -->
        <button
            type="button"
            class="quick-emergency-btn"
            id="quickEmergencyBtn"
            title="Emergency SOS">

            <svg class="icon icon-sm" viewBox="0 0 24 24" aria-hidden="true">
                <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
            </svg>

            <span>Emergency SOS</span>

        </button>


        <!-- Shopping Cart -->
        <button
            type="button"
            class="icon-action-btn"
            id="cartButton"
            title="Shopping Cart"
            aria-label="Shopping Cart">

            <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                <circle cx="8" cy="21" r="1"/>
                <circle cx="19" cy="21" r="1"/>
                <path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/>
            </svg>

            <!-- Cart notification indicator -->
            <span
                class="badge-dot cart-badge"
                id="cartDot"
                aria-hidden="true"
                style="display: none;">
            </span>

        </button>


        <!-- Notifications -->
        <button
            type="button"
            class="icon-action-btn"
            id="notificationButton"
            title="Notifications"
            aria-label="Notifications">

            <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9"/>
                <path d="M10.3 21a1.94 1.94 0 0 0 3.4 0"/>
            </svg>

            <!-- Unread notification indicator -->
            <span
                class="badge-dot notification-badge"
                id="notificationDot"
                aria-hidden="true">
            </span>

        </button>

    </div>

</header>