function [du_b] = err_shot(s, f, x_rng, u_bndry, h, eps_abs)
    u_a = u_bndry(1);
    u_b = u_bndry(2);

    [~, u_out] = dp45( f, x_rng, [u_a, s]', h, eps_abs );
    du_b = u_out(1, end) - u_b;
end
