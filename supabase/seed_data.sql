-- Insert test ingredients
INSERT INTO public.ingredients (name, quantity, quantity_type, expiration, notes, user_id)
VALUES
  ('Chicken Breast', 500, 'G', NOW() + INTERVAL '5 days', 'Fresh from local market', '0c89e606-d9a5-48e8-ac16-515cda1391a7'),
  ('Rice', 1, 'KG', NOW() + INTERVAL '60 days', 'Basmati rice', '0c89e606-d9a5-48e8-ac16-515cda1391a7'),
  ('Tomatoes', 6, 'PCS', NOW() + INTERVAL '7 days', 'Roma tomatoes', '0c89e606-d9a5-48e8-ac16-515cda1391a7'),
  ('Olive Oil', 500, 'ML', NOW() + INTERVAL '180 days', 'Extra virgin', '0c89e606-d9a5-48e8-ac16-515cda1391a7'),
  ('Garlic', 1, 'PCS', NOW() + INTERVAL '14 days', 'Fresh garlic bulb', '0c89e606-d9a5-48e8-ac16-515cda1391a7');

-- Insert test recipes
WITH new_recipes AS (
  INSERT INTO public.recipes (title, time, instructions, image_url, notes, created_by_id)
  VALUES
    (
      'Chicken and Rice',
      45,
      '1. Cook rice according to package instructions
2. Season chicken with salt and pepper
3. Cook chicken in olive oil until golden
4. Serve chicken over rice',
      'https://example.com/chicken-rice.jpg',
      'A simple and healthy meal',
      '0c89e606-d9a5-48e8-ac16-515cda1391a7'
    ),
    (
      'Tomato Garlic Pasta',
      30,
      '1. Boil pasta
2. Sauté garlic in olive oil
3. Add chopped tomatoes
4. Toss with pasta',
      'https://example.com/tomato-pasta.jpg',
      'Quick weeknight dinner',
      '0c89e606-d9a5-48e8-ac16-515cda1391a7'
    )
  RETURNING id, title
)
-- Insert recipe ingredients relationships
INSERT INTO public.recipe_ingredients (recipe_id, ingredient_id, quantity, quantity_type, notes)
SELECT 
  r.id as recipe_id,
  i.id as ingredient_id,
  CASE 
    WHEN r.title = 'Chicken and Rice' AND i.name = 'Chicken Breast' THEN 200
    WHEN r.title = 'Chicken and Rice' AND i.name = 'Rice' THEN 200
    WHEN r.title = 'Chicken and Rice' AND i.name = 'Olive Oil' THEN 30
    WHEN r.title = 'Tomato Garlic Pasta' AND i.name = 'Tomatoes' THEN 4
    WHEN r.title = 'Tomato Garlic Pasta' AND i.name = 'Garlic' THEN 3
    WHEN r.title = 'Tomato Garlic Pasta' AND i.name = 'Olive Oil' THEN 45
  END as quantity,
  CASE 
  WHEN r.title = 'Chicken and Rice' AND i.name = 'Chicken Breast' THEN 'G'::unit_type
  WHEN r.title = 'Chicken and Rice' AND i.name = 'Rice' THEN 'G'::unit_type
  WHEN r.title = 'Chicken and Rice' AND i.name = 'Olive Oil' THEN 'ML'::unit_type
  WHEN r.title = 'Tomato Garlic Pasta' AND i.name = 'Tomatoes' THEN 'PCS'::unit_type
  WHEN r.title = 'Tomato Garlic Pasta' AND i.name = 'Garlic' THEN 'PCS'::unit_type
  WHEN r.title = 'Tomato Garlic Pasta' AND i.name = 'Olive Oil' THEN 'ML'::unit_type
  END as quantity_type,
  CASE 
    WHEN r.title = 'Chicken and Rice' AND i.name = 'Chicken Breast' THEN 'Sliced'
    WHEN r.title = 'Chicken and Rice' AND i.name = 'Rice' THEN 'Rinsed'
    WHEN r.title = 'Tomato Garlic Pasta' AND i.name = 'Tomatoes' THEN 'Diced'
    WHEN r.title = 'Tomato Garlic Pasta' AND i.name = 'Garlic' THEN 'Minced cloves'
    ELSE NULL
  END as notes
FROM new_recipes r
CROSS JOIN public.ingredients i
WHERE 
  (r.title = 'Chicken and Rice' AND i.name IN ('Chicken Breast', 'Rice', 'Olive Oil'))
  OR 
  (r.title = 'Tomato Garlic Pasta' AND i.name IN ('Tomatoes', 'Garlic', 'Olive Oil'));