## Registración de Imágenes Multimodales

Este repositorio cuenta con una serie de *scripts* que permiten registrar imágenes médicas provenientes de diferentes fuentes (registración multimodal).

### MIFullRegister

Registración a través de *fuerza bruta*. Realiza una serie de combinaciones pre-configuradas correspondiente a los movimientos de rotación y traslación con el objetivo de obtener el valor máximo de la información mutua entre las imágenes *fixed* y *moving*. Dado que este procesamiento demora muchas horas (incluso días) se utiliza *parallel computing*. 

<p align="center"><img src="https://github.com/ahestevenz/ip-image-registration/blob/master/img/MIFullRegister.png" width="600"></p>

En la figura se muestra el resultado de este *script*.

### MetropolisMIRegister

El algoritmo implementado en este *script* utiliza la información mutua y la técnica Metrópolis como medida de similitud y método de búsqueda estocástica respectivamente. La fusión de imágenes 2D se realizó
a partir de la maximización de su información mutua y con transformaciones de rotación y traslación, con resultados satisfactorios en cuanto a la alineación geométrica de las mismas. Este trabajo se realizó en el contexto del proyecto ARPET*. 

<p align="center"><img src="https://github.com/ahestevenz/ip-image-registration/blob/master/img/MetropolisMIRegister.png" width="800"></p>

Este trabajo se encuentra publicado en la revista [Proyecciones Vol.14 No. 1](https://www.frba.utn.edu.ar/wp-content/uploads/2016/05/proyecciones-16-v1-new.pdf)

### IPTBNCTRegister

Registración de imágenes utilizando el [Image Processing Toolbox](https://www.mathworks.com/products/image/). Este *script* tiene como objetivo registrar imágenes radiográficas e histológicas proveniente de muestras correspondientes al proyecto [BNCT](http://www2.cnea.gov.ar/aplicaciones_nucleares/bnct_proyecto.php) del [Centro Atómico Constituyentes](http://www.cnea.gov.ar/como-visitarnos-CAC) de la [CNEA](http://www.cnea.gov.ar/).

<p align="center"><img src="https://github.com/ahestevenz/ip-image-registration/blob/master/img/IPTBNCTRegister.png" width="800"></p>

En la figura se muestra el resultado de este *script*.


*AR-PET: Primer Tomógrafo por Emsión de Positrones Argentino, C. Verrastro, D. Estryk, E. Venialgo, S. Marinsek, M. Belzunce, XXXV Reunión Anual de la Asociación Argentina de Tecnología Nuclear, Noviembre 2008.
