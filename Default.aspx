<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="_Default" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="page-header">
            <h3><i class="bi bi-speedometer2"></i> ADMIN DASHBOARD</h3>
        </div>
        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false" />

        <!-- Stats Row -->
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="card stat-card" style="border-top: 4px solid var(--primary-red);">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="stat-label">Total Movies</div>
                            <i class="bi bi-film text-danger fs-4"></i>
                        </div>
                        <div class="stat-value">
                            <asp:Label ID="lblMovies" runat="server" />
                        </div>
                        <div class="text-muted small">Library Catalog</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card" style="border-top: 4px solid #4361ee;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="stat-label">Tickets Sold</div>
                            <i class="bi bi-ticket-perforated text-primary fs-4"></i>
                        </div>
                        <div class="stat-value">
                            <asp:Label ID="lblTickets" runat="server" />
                        </div>
                        <div class="text-muted small">All Time Sales</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card" style="border-top: 4px solid #2ec4b6;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="stat-label">Revenue</div>
                            <i class="bi bi-wallet2 text-success fs-4"></i>
                        </div>
                        <div class="stat-value">Rs
                            <asp:Label ID="lblRevenue" runat="server" Text="0" />
                        </div>
                        <div class="text-muted small">Gross Earnings</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card" style="border-top: 4px solid #ff9f1c;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="stat-label">Seat Usage</div>
                            <i class="bi bi-percent text-warning fs-4"></i>
                        </div>
                        <div class="stat-value">
                            <asp:Label ID="lblAvgOccupancy" runat="server" Text="0" />%
                        </div>
                        <div class="text-muted small">Avg Occupancy</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="row g-4 mb-5">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header border-0 bg-transparent py-4">
                        <h5 class="m-0 fw-bold">Revenue Trend</h5>
                        <p class="text-muted small m-0">Monthly sales performance</p>
                    </div>
                    <div class="card-body">
                        <div style="height: 320px;">
                            <canvas id="salesChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-header border-0 bg-transparent py-4">
                        <h5 class="m-0 fw-bold">Hall Distribution</h5>
                        <p class="text-muted small m-0">Current occupancy spread</p>
                    </div>
                    <div class="card-body">
                        <div style="height: 320px;">
                            <canvas id="occupancyChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Sales Table & Quick Actions -->
        <div class="row g-4 pb-5">
            <div class="col-md-8">
                <div class="card h-100 border-0 shadow-sm">
                    <div
                        class="card-header border-0 bg-transparent py-4 d-flex justify-content-between align-items-center">
                        <h5 class="m-0 fw-bold">Recent Bookings</h5>
                        <a href='<%= ResolveUrl("~/Forms/Basic/TicketForm.aspx") %>'
                            class="btn btn-sm btn-light px-3 text-danger fw-bold">View All</a>
                    </div>
                    <div class="card-body p-0">
                        <asp:GridView ID="gvRecent" runat="server" CssClass="table table-hover mb-0"
                            AutoGenerateColumns="false" EmptyDataText="No recent sales found." GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="TicketId" HeaderText="ID" ItemStyle-CssClass="ps-4"
                                    HeaderStyle-CssClass="ps-4" />
                                <asp:BoundField DataField="Username" HeaderText="Customer" />
                                <asp:BoundField DataField="MovieTitle" HeaderText="Movie" />
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate><span class="fw-bold">Rs <%# Eval("TicketPrice", "{0:N0}" ) %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="pe-4"
                                    HeaderStyle-CssClass="pe-4">
                                    <ItemTemplate>
                                        <span
                                            class='badge rounded-pill px-3 <%# Eval("TicketStatus").ToString() == "Paid" ? "bg-success-subtle text-success" : "bg-warning-subtle text-warning" %>'>
                                            <%# Eval("TicketStatus") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="card-header border-0 bg-transparent py-4">
                        <h5 class="m-0 fw-bold">Quick Management</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush gap-2">
                            <a href='<%= ResolveUrl("~/Forms/Basic/MovieForm.aspx") %>'
                                class="list-group-item list-group-item-action border-0 rounded-3 bg-light-subtle d-flex align-items-center">
                                <div class="bg-danger-subtle p-2 rounded-2 me-3"><i
                                        class="bi bi-plus-circle text-danger"></i></div>
                                Add New Movie
                            </a>
                            <a href='<%= ResolveUrl("~/Forms/Basic/ShowForm.aspx") %>'
                                class="list-group-item list-group-item-action border-0 rounded-3 bg-light-subtle d-flex align-items-center">
                                <div class="bg-primary-subtle p-2 rounded-2 me-3"><i
                                        class="bi bi-calendar-plus text-primary"></i></div>
                                Schedule Show
                            </a>
                            <a href='<%= ResolveUrl("~/Forms/Complex/OccupancyForm.aspx") %>'
                                class="list-group-item list-group-item-action border-0 rounded-3 bg-light-subtle d-flex align-items-center">
                                <div class="bg-success-subtle p-2 rounded-2 me-3"><i
                                        class="bi bi-download text-success"></i></div>
                                Occupancy Report
                            </a>
                            <a href='<%= ResolveUrl("~/Forms/Complex/UserTicketForm.aspx") %>'
                                class="list-group-item list-group-item-action border-0 rounded-3 bg-light-subtle d-flex align-items-center">
                                <div class="bg-warning-subtle p-2 rounded-2 me-3"><i
                                        class="bi bi-search text-warning"></i></div>
                                User History
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chart Scripts -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Shared config
                Chart.defaults.font.family = "'Outfit', sans-serif";
                Chart.defaults.color = "#64748b";

                // Sales Chart
                const salesCtx = document.getElementById('salesChart').getContext('2d');
                const gradient = salesCtx.createLinearGradient(0, 0, 0, 400);
                gradient.addColorStop(0, 'rgba(255, 59, 63, 0.2)');
                gradient.addColorStop(1, 'rgba(255, 59, 63, 0)');

                new Chart(salesCtx, {
                    type: 'line',
                    data: {
                        labels: <%= GetChartLabels() %>,
                    datasets: [{
                        label: 'Revenue',
                        data: <%= GetChartData() %>,
                        borderColor: '#ff3b3f',
                        backgroundColor: gradient,
                        borderWidth: 4,
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#ffffff',
                        pointBorderColor: '#ff3b3f',
                        pointBorderWidth: 2,
                        pointRadius: 6,
                        pointHoverRadius: 8
                    }]
                },
                options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { borderDash: [5, 5], color: '#f1f5f9' }, border: { display: false } },
                    x: { grid: { display: false }, border: { display: false } }
                }
            }
            });

            // Occupancy Chart
            const occCtx = document.getElementById('occupancyChart').getContext('2d');
            new Chart(occCtx, {
                type: 'doughnut',
                data: {
                    labels: <%= GetOccupancyLabels() %>,
                datasets: [{
                    data: <%= GetOccupancyData() %>,
                    backgroundColor: ['#ff3b3f', '#4361ee', '#2ec4b6', '#ff9f1c', '#94a3b8'],
                    borderWidth: 4,
                    borderColor: '#ffffff',
                    hoverOffset: 15
                    }]
                },
                options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom', labels: { usePointStyle: true, padding: 25, font: { size: 12 } } }
                },
                cutout: '75%',
                spacing: 5
            }
            });
        });
        </script>
    </asp:Content>